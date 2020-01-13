FROM r-base:3.6.0 

RUN apt update && apt install -y libcurl4-openssl-dev   
RUN R -e "install.packages('remotes')"
RUN R -e "remotes::install_github('Zouter/MPath')"
