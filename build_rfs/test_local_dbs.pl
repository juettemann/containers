
use Bio::EnsEMBL::DBSQL::DBAdaptor;
use Bio::EnsEMBL::Funcgen::DBSQL::DBAdaptor;
use Data::Dumper;
use feature qw(say);

my $options = {};

$options->{user} = 'root';
$options->{db} = 'homo_sapiens_funcgen_103_38';
$options->{host} = 127.0.0.1;
$options->{pass} = '';
$options->{port} = 3306;
$options->{species} = 'homo sapiens';
$options->{dnadb_user} = 'root';
$options->{dnadb_name} = 'homo_sapiens_core_102_38';
$options->{dnadb_host} = '127.0.0.1';
$options->{dnadb_pass} = '';
$options->{dnadb_port} = 3306;


if (defined $options->{host}) {
    $options->{db_adaptor} = Bio::EnsEMBL::Funcgen::DBSQL::DBAdaptor->new
    (
      -user   => $options->{user},
      -dbname => $options->{db},
      -host   => $options->{host},
      -pass   => $options->{pass},
      -port   => $options->{port},
      -species => $options->{species},
      -dnadb_user   => $options->{dnadb_user},
      -dnadb_dbname => $options->{dnadb_name},
      -dnadb_host   => $options->{dnadb_host},
      -dnadb_pass   => $options->{dnadb_pass},
      -dnadb_port   => $options->{dnadb_port}
    );
    $options->{dnadb_adaptor} = Bio::EnsEMBL::DBSQL::DBAdaptor->new
    (
      -user   => $options->{dnadb_user},
      -dbname => $options->{dnadb_name},
      -host   => $options->{dnadb_host},
      -pass   => $options->{dnadb_pass},
      -port   => $options->{dnadb_port},
      -species => $options->{species},
    );
  }

say Dumper ($options);
