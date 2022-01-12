FROM rocker/r-ver:4.1.2
RUN apt-get update && apt-get install -y  gdal-bin git-core libcurl4-openssl-dev libgdal-dev libgeos-dev libgeos++-dev libgit2-dev libicu-dev libpng-dev libproj-dev libssl-dev libudunits2-dev libxml2-dev make pandoc pandoc-citeproc zlib1g-dev
RUN apt-get install -y gdal-bin git-core libcurl4-openssl-dev libgdal-dev libgeos-dev libgeos++-dev libgit2-dev libicu-dev libpng-dev libproj-dev libssl-dev libudunits2-dev libxml2-dev make pandoc pandoc-citeproc 
RUN apt-get install -y fonts-roboto fonts-roboto-fontface libfontconfig1-dev libcairo2-dev 
RUN apt-get install -y libxtst6 texlive-xetex texlive-lang-italian xzdec
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl', Ncpus = 4)" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_version("terra",upgrade="never", version = "1.4-22")'
RUN Rscript -e 'remotes::install_version("jsonlite",upgrade="never", version = "1.7.2")'
RUN Rscript -e 'remotes::install_version("htmltools",upgrade="never", version = "0.5.2")'
RUN Rscript -e 'remotes::install_version("magrittr",upgrade="never", version = "2.0.1")'
RUN Rscript -e 'remotes::install_version("glue",upgrade="never", version = "1.6.0")'
RUN Rscript -e 'remotes::install_version("tibble",upgrade="never", version = "3.1.6")'
RUN Rscript -e 'remotes::install_version("knitr",upgrade="never", version = "1.37")'
RUN Rscript -e 'remotes::install_version("attempt",upgrade="never", version = "0.3.1")'
RUN Rscript -e 'remotes::install_version("dplyr",upgrade="never", version = "1.0.7")'
RUN Rscript -e 'remotes::install_version("shiny",upgrade="never", version = "1.7.1")'
RUN Rscript -e 'remotes::install_version("config",upgrade="never", version = "0.3.1")'
RUN Rscript -e 'remotes::install_version("ggplot2",upgrade="never", version = "3.3.5")'
RUN Rscript -e 'remotes::install_version("sf",upgrade="never", version = "1.0-5")'
RUN Rscript -e 'remotes::install_version("waiter",upgrade="never", version = "0.2.5")'
RUN Rscript -e 'remotes::install_version("rmarkdown",upgrade="never", version = "2.11")'
RUN Rscript -e 'remotes::install_version("qrencoder",upgrade="never", version = "0.1.0")'
RUN Rscript -e 'remotes::install_version("gt",upgrade="never", version = "0.3.1")'
RUN Rscript -e 'remotes::install_version("golem",upgrade="never", version = "0.3.1")'
RUN Rscript -e 'remotes::install_version("ggspatial",upgrade="never", version = "1.1.5")'
RUN Rscript -e 'remotes::install_version("ggrepel",upgrade="never", version = "0.9.1")'
RUN Rscript -e 'remotes::install_version("extrafont",upgrade="never", version = "0.17")'
RUN Rscript -e 'remotes::install_version("DT",upgrade="never", version = "0.20")'
RUN R -e 'extrafont::font_import(prompt=FALSE)'
RUN R -e 'extrafont::loadfonts()'
RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
RUN R -e 'remotes::install_local(upgrade="never")'
RUN rm -rf /build_zone
EXPOSE 80
CMD R -e "options('shiny.port'=80,shiny.host='0.0.0.0');gpx2pdf::run_app()"