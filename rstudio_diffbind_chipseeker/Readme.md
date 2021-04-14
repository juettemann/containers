# R Studio / Bioconductor with ChIPseeker and DiffBind

Links:
* [Bioconductor] (http://bioconductor.org/)
* [ChIPseeker] (https://www.bioconductor.org/packages/release/bioc/html/ChIPseeker.html)
* [DiffBind] (https://www.bioconductor.org/packages/release/bioc/html/DiffBind.html)

## Run
```bash
 docker run \
     -e PASSWORD=bioc \
     -p 8787:8787 \
     bioconductor/bioconductor_docker:devel
```

Open Browser
```html
http://localhost:8787
user: rstudio
```
