FROM python:3.6 

RUN mkdir /src
WORKDIR /src 
RUN git clone https://github.com/linnarsson-lab/BackSPIN && \
    cd BackSPIN && \
    python setup.py install 
