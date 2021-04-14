# R Studio / Bioconductor with ChIPseeker and DiffBind

Links to sources:
* [Bioconductor](http://bioconductor.org/)
* [ChIPseeker](https://www.bioconductor.org/packages/release/bioc/html/ChIPseeker.html)
* [DiffBind](https://www.bioconductor.org/packages/release/bioc/html/DiffBind.html)

## Run
```bash
 docker run \
     -e PASSWORD=bioc \
     -p 8787:8787 \
     juettemann/rstudio_diffbind_chipseeker
```

Open Browser
* [http://localhost:8787](http://localhost:8787)
* user: rstudio
