FROM centos:centos7

RUN yum -y install wget; yum clean all && \
        groupadd --gid 1001 elasticsearch && \
        adduser --uid 1001 --gid 1001 --home /usr/share/elasticsearch elasticsearch && \
        mkdir /var/lib/elasticsearch/ && \
        chown -R 1001:1001 /var/lib/elasticsearch/

RUN mkdir /var/lib/data /usr/share/elasticsearch/snapshots /var/log/elasticsearch
RUN chown 1001:1001 /var/lib/data /usr/share/elasticsearch/snapshots /var/log/elasticsearch

USER 1001

WORKDIR /usr/share/elasticsearch

RUN wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.0-linux-x86_64.tar.gz && \
        tar -xzf elasticsearch-8.2.0-linux-x86_64.tar.gz && \
        cp -rp elasticsearch-8.2.0/* ./ && \
        rm -rf elasticsearch-8.2.0*

COPY ./config/elasticsearch.yml /usr/share/elasticsearch/config/

EXPOSE 9200

CMD ["bin/elasticsearch"]
