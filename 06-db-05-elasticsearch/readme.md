# Задача 1

Dockerfile  
```
FROM centos:centos7

RUN yum -y install wget; yum clean all && \
        groupadd --gid 1001 elasticsearch && \
        adduser --uid 1001 --gid 1001 --home /usr/share/elasticsearch elasticsearch && \
        mkdir /var/lib/elasticsearch/ && \
        chown -R 1001:1001 /var/lib/elasticsearch/

RUN mkdir /var/lib/data /var/log/elasticsearch
RUN chown 1001:1001 /var/lib/data /var/log/elasticsearch

USER 1001

WORKDIR /usr/share/elasticsearch

RUN wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.0-linux-x86_64.tar.gz && \
        tar -xzf elasticsearch-8.2.0-linux-x86_64.tar.gz && \
        cp -rp elasticsearch-8.2.0/* ./ && \
        rm -rf elasticsearch-8.2.0*

COPY ./config/elasticsearch.yml /usr/share/elasticsearch/config/

EXPOSE 9200

CMD ["bin/elasticsearch"]
```
Файл конфигурации elasticsearch:  
```
node.name: "netology_test"
cluster.name: "netology"
network.host: 0.0.0.0
discovery.type: single-node

path.data: /var/lib/data
path.logs: /var/log/elasticsearch

xpack.security.enabled: false
```

Ссылка на репозиторий github: https://hub.docker.com/repository/docker/wedun/elastic

Запрос /
```
curl -X GET localhost:9200/
{
  "name" : "netology_test",
  "cluster_name" : "netology",
  "cluster_uuid" : "orvv_zb7RLKC96Q1zD1k5w",
  "version" : {
    "number" : "8.2.0",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "b174af62e8dd9f4ac4d25875e9381ffe2b9282c5",
    "build_date" : "2022-04-20T10:35:10.180408517Z",
    "build_snapshot" : false,
    "lucene_version" : "9.1.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

# Задача 2
Добавил индексы  
```
curl -X PUT "localhost:9200/ind-1?pretty" -H 'Content-Type: application/json' -d'{"settings": {"number_of_shards": 1,"number_of_replicas": 0}}'
curl -X PUT "localhost:9200/ind-2?pretty" -H 'Content-Type: application/json' -d'{"settings": {"number_of_shards": 2,"number_of_replicas": 1}}'
curl -X PUT "localhost:9200/ind-3?pretty" -H 'Content-Type: application/json' -d'{"settings": {"number_of_shards": 4,"number_of_replicas": 2}}'
```
Список индексов: 
``` 
curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
yellow open   ind-2 vj9dYLMFQAOn-1NRhYtG8w   2   1          0            0       450b           450b
yellow open   ind-3 HuVQD4IxQByOVjIWFsx3UA   4   2          0            0       900b           900b
green  open   ind-1 SGYugb3FQpq4g_VRgx0IcQ   1   0          0            0       225b           225b
```
Статусы индексов:
```
curl -X GET 'http://localhost:9200/_cluster/health/ind-1?pretty'
{
  "cluster_name" : "netology",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 1,
  "active_shards" : 1,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}

curl -X GET 'http://localhost:9200/_cluster/health/ind-2?pretty'
{
  "cluster_name" : "netology",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 2,
  "active_shards" : 2,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 2,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 44.44444444444444
}

curl -X GET 'http://localhost:9200/_cluster/health/ind-3?pretty'
{
  "cluster_name" : "netology",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 4,
  "active_shards" : 4,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 8,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 44.44444444444444
}
```
Получите состояние кластера elasticsearch, используя API.
```
curl -X GET 'http://localhost:9200/_cluster/health/?pretty=true'
{
  "cluster_name" : "netology",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 8,
  "active_shards" : 8,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 44.44444444444444
}
```

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?  
Мы запустили single-node кластер, но при этом указали для части индексов число реплик. Т.к. индексы не могут быть реплицированы на другой сервер, то elasticsearch установил им статус yellow.  

Удалите все индексы.  
```
curl -X DELETE 'http://localhost:9200/ind-1?pretty'
{
  "acknowledged" : true
}
curl -X DELETE 'http://localhost:9200/ind-2?pretty'
{
  "acknowledged" : true
}
curl -X DELETE 'http://localhost:9200/ind-3?pretty'
{
  "acknowledged" : true
}
```

# Задача 3

Создайте директорию {путь до корневой директории с elasticsearch в образе}/snapshots.
```
[elasticsearch@7dca9159d17e ~]$ pwd
/usr/share/elasticsearch/snapshots
```

Используя API зарегистрируйте данную директорию как snapshot repository c именем netology_backup.
```
curl -X POST localhost:9200/_snapshot/netology_backup?pretty -H 'Content-Type: application/json' -d'{"type": "fs", "settings": { "location":"/usr/share/elasticsearch/snapshots" }}'
{
  "acknowledged" : true
}

curl -X GET 'http://localhost:9200/_snapshot/netology_backup?pretty'
{
  "netology_backup" : {
    "type" : "fs",
    "settings" : {
      "location" : "/usr/share/elasticsearch/snapshots"
    }
  }
}
```
Создайте индекс test с 0 реплик и 1 шардом и приведите в ответе список индексов.
```
curl -X PUT localhost:9200/test -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'
{
  "acknowledged":true,
  "shards_acknowledged":true,
  "index":"test"
}

curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test  wuiFZ4XBSI6hkju5ug2hLQ   1   0          0            0       225b           225b
```

