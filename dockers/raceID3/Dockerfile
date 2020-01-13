FROM r-base:3.6.0 

RUN apt update && apt install -y libssl-dev libcurl4-openssl-dev libxml2-dev 

RUN R -e "install.packages('remotes', dependencies=TRUE)"
RUN R -e "remotes::install_github('dgrun/RaceID3_StemID2_package')"