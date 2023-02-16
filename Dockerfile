FROM centos:7

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)"

ARG CELLRANGER_VERSION=7.1.0
ARG VDJ_REFERENCE_VERSION=7.1.0
ARG DOWNLOAD_URL="https://cf.10xgenomics.com/releases/cell-vdj/cellranger-7.1.0.tar.gz?Expires=1676501879&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9jZi4xMHhnZW5vbWljcy5jb20vcmVsZWFzZXMvY2VsbC12ZGovY2VsbHJhbmdlci03LjEuMC50YXIuZ3oiLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE2NzY1MDE4Nzl9fX1dfQ__&Signature=UTGY2rNgiY071A6Nxb77VvnHOPRfPGvYezNF-vsRkNMLSW1jyiTbf88WChHhvhhDSy8mI63181BFj~7qn28FzP6hYUAVn4IUoqb4MT2NA7CLmpyG6ch2mKzhtpQy~n38tYFQk4n2NpwB-RW0nD71p20wSdkujbT2j8Hh5T8JekZdTT0EZwzV~GuI8X9ZO1TmKPx0ChTMo5nXHToL4cb367DQLsrQxzPvbKOf~dc0hOAzUH5eUsHAat3zsmpheZSLeYOUM4q7YWRkKWzL8MUepRLdz6VQ6SyD6LJcvibXaqSaajYZ~AESxPA5jWWV-WDIoYgh5fZagX-PqqaYmjowsA__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA"
ENV PATH /opt/cellranger-${CELLRANGER_VERSION}:$PATH

RUN yum install nano -y

# cell ranger binaries
RUN curl -o cellranger-${CELLRANGER_VERSION}.tar.gz ${DOWNLOAD_URL} \
    && tar xzf cellranger-${CELLRANGER_VERSION}.tar.gz \
    && rm -rf cellranger-${CELLRANGER_VERSION}.tar.gz \
    && mv cellranger-${CELLRANGER_VERSION} /opt/

# V(D)J GRCh38 Reference - 7.0.0 (May 17, 2022)
RUN curl -O https://cf.10xgenomics.com/supp/cell-vdj/refdata-cellranger-vdj-GRCh38-alts-ensembl-${VDJ_REFERENCE_VERSION}.tar.gz \
    && tar xzf refdata-cellranger-vdj-GRCh38-alts-ensembl-${VDJ_REFERENCE_VERSION}.tar.gz \
    && rm -rf refdata-cellranger-vdj-GRCh38-alts-ensembl-${VDJ_REFERENCE_VERSION}.tar.gz \
    && mv refdata-cellranger-vdj-GRCh38-alts-ensembl-${VDJ_REFERENCE_VERSION} /opt/

# GRCh38 Human Reference
RUN curl -O curl -O https://cf.10xgenomics.com/supp/cell-vdj/refdata-gex-GRCh38-2020-A.tar.gz\
    && tar xzf refdata-gex-GRCh38-2020-A.tar.gz \
    && rm -rf refdata-gex-GRCh38-2020-A.tar.gz \
    && mv refdata-gex-GRCh38-2020-A /opt/

WORKDIR /opt
