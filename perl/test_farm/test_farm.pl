use strict;
use warnings;
use feature qw /say/;
use DBI;
use Getopt::Long;
use Data::Dumper;

$Data::Dumper::Indent   = 2;
$Data::Dumper::Sortkeys = 1;
$Data::Dumper::Deepcopy = 1;
$Data::Dumper::Terse    = 1;

# These could be made optional
use Bio::EnsEMBL::DBSQL::DBAdaptor;
use Bio::EnsEMBL::Funcgen::DBSQL::DBAdaptor;
use Bio::EnsEMBL::Utils::SqlHelper;

=head 1

Test Docker/Singularity access
--dnadb
--db
--directories

Database
All connection details are expected to be available in the environment

=cut

open (FH_LOG, '>', "$0.log") or die "Could not open log: $!";

sub get_options {

  #splitting command line options, predeclaration required
  my $options = {
      directories => [],
  };

  # split command line arguments into comma separated list
  my $splitter = sub {
    my ($name, $val) = @_;
    push @{$options->{$name}}, split q{,}, $val;
  };

  GetOptions($options,
    'directories=s@' => $splitter,
    'db',
    'dnadb',
    'rw_user=s',
    'rw_pass=s',
    'ro_user=s',
    'species=s',
    'db_name=s',
    'db_host=s',
    'db_port=s',
    'dnadb_name=s',
    'dnadb_host=s',
    'dnadb_port=s',
  );
# Always test those
  push(@{$options->{directories}},'/tmp');
  push(@{$options->{directories}},$ENV{HOME});
  return $options;
}

sub test_directories {
  my ($options) = @_;
  foreach my $dir (@{$options->{directories}}){
    if(-e $dir){
      my $mode = (stat($dir))[2];
      printf FH_LOG "$dir\t%04o\n", $mode &07777 ;
    }
    else{
      say FH_LOG "$dir does not exist";
    }
  }
}

# Creates DB connections
sub connect_db {
  my ($options) = @_;
 
  if($options->{db}){
    $options->{db_adaptor} = Bio::EnsEMBL::DBSQL::DBAdaptor->new (
      -user     => $options->{rw_user},
      -pass     => $options->{rw_pass},
      -dbname   => $options->{db_name},
      -host     => $options->{db_host},
      -port     => $options->{db_port},
      -species  => $options->{species},
      -reconnect_when_connection_lost => 1,
    );
    ref($options->{db_adaptor}) eq 'Bio::EnsEMBL::DBSQL::DBAdaptor' ?  say FH_LOG "Connected to DB" : say FH_LOG  "Could not connect to DB";

    $options->{dbc} = $options->{db_adaptor}->dbc();
    my $helper = Bio::EnsEMBL::Utils::SqlHelper->new( -DB_CONNECTION => $options->{dbc} );
    # Error message from DBD will still be printed, check how to pass PrintError=>0 when creating the dbc
    eval{
      $helper->execute_simple( -SQL => 'drop database if exists tj_createdb_test', );
      $helper->execute_simple( -SQL => 'create database tj_createdb_test', );
    };
    if ($@) {
      say FH_LOG "Could not access DB for writing";
    }
    
  }  
    
  $options->{dnadb_adaptor} = Bio::EnsEMBL::DBSQL::DBAdaptor->new (
    -user     => $options->{ro_user},
    -dbname   => $options->{dnadb_name},
    -host     => $options->{dnadb_host},
    -port     => $options->{dnadb_port},
    -species  => $options->{species},
    -reconnect_when_connection_lost => 1,
  );
  ref($options->{dnadb_adaptor}) eq 'Bio::EnsEMBL::DBSQL::DBAdaptor' ?  say FH_LOG "Connected to DNADB" : say FH_LOG "Could not connect to DNADB";
}

my $options = get_options();


connect_db($options);
test_directories($options);

say STDOUT "Testing STDOUT";
say STDERR "Testing STDERR";
