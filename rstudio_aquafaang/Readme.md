# R Studio with all libraries for the AquaFaang course pre-installed

Links to sources:
* [Bioconductor](http://bioconductor.org/)
* [ChIPseeker](https://www.bioconductor.org/packages/release/bioc/html/ChIPseeker.html)
* [DiffBind](https://www.bioconductor.org/packages/release/bioc/html/DiffBind.html)
* [GenomicFeature](https://www.bioconductor.org/packages/release/bioc/html/GenomicFeatures.html])
* [Tidyverse](https://www.tidyverse.org/)

## Run
```bash
 docker run \
     -e PASSWORD=bioc \
     -p 8787:8787 \
     --mount type=bind,source="$(pwd)",target=/mnt \
     juettemann/rstudio_aquafaang
```

Open Browser
* [http://localhost:8787](http://localhost:8787)
* user: rstudio

All files in the PWD are accessible in /mnt
