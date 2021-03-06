# Задача 1
* Электронные чеки в json виде: Эти данные можно сохранить в документной NoSQL СУБД. Примером является MongoDB. Это решение подходит из-за представления данных в Json полобном формате. По мимо этого MongoDB обеспечивает строгую консистентность данных. Также для хранения этой информации можно использовать СУБД, у которой есть возможность хранения записей в Json формате (PostgreSQL c Jsonb)
* Склады и автомобильные дороги для логистической компании. Эти данные можно хранить в графовой NoSQL СУБД. Т.к. при использовании этого типа СУБД мы получим преимущество в хранении связей между складами и описании складов. Пример Neo4j. Также для решения этой задачи можно использовать реляционные СУБД, т.к. данные можно нормализовать. Также можно использовать сетевую СУБД.
* Генеалогические деревья. Эти данные лучше хранить в сетевых NoSQL СУБД. Данные в этих СУБД организованы в виде связных между собой вершин. За счёт этого мы получим преимущество в хранении записей в базе. Также для решения этой задачи можно использовать реляционные СУБД, т.к. данные можно нормализовать. Также можно использовать графовую СУБД. В вершинах графа будут храниться информация о родителях и потомках, в рёбрах графа будет храниться информация о родственных связях. За счёт такого способа хранения информации о генеалогических деревьях, мы получим более эффективное хранение информации в базе и простые запросы при работе с данными в базе.
* Кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации. Эти данные лучше сохранить в СУБД типа "ключ-значение". Подходящим примером являются Redis и Memcached. Они предоставляютя быструю СУБД подходящую для задачи кеширования. Также они поддерживают Time-To-Live для записей.
* Отношения клиент-покупка для интернет-магазина: Эти данные можно харнять в реуляционной СУБД. Отношение клиент-покупка хорошо нормализуются. Соответственно мы можем организовать эффективное представление этих данных в СУБД. Из NoSQL решений можно использовать графовую СУБД.

# Задача 2
* Данные записываются на все узлы с задержкой до часа (асинхронная запись) - По CAP теореме это AP система, по PACELC это PA/EL система.  
Комментарий:  
"Может ли система с асинхронной репликацией (а значит вероятно с быстрым ответом, т.е. с хорошим Latency) быть одновременно Consistent на всех репликах?" - Нет, т.к. репликация асинхронная и нет возможности гарантировать что в один момент времени данные будут консистентными на всех нодах СУБД.  
* При сетевых сбоях, система может разделиться на 2 раздельных кластера - По CAP теореме это AP система, по PACELC это PA/EL система.  
Комментарий:   
"Разве CA система сохраняет работоспособность после разделения на части?" - Нет или частично, т.к. CA система гарантирует консистентность и доступность данных. При разделении на два кластера CA система должна остановить операции по добавлению/изменению данных пока связь не будет восстановлена.   
Комментарий 2:  
"Почему именно AP? Какие еще варианты могут быть устойчивы к разделению?" - Системы, устойчивые к разделению: AP и CP. AP система, т.к. при разделении данные продолжают быть доступными. Но, т.к. система разделена на две части, что она уже не может гарантировать консистентность данных, соответственно не может быть CP системой.   
Комментарий 3:  
"При сетевых сбоях, система может разделиться на 2 раздельных кластера" - действительно из условий задачи мы не знаем доступны ли данные в базе и согласованы ли они.
Если данные в базе согласованы, т.е. запрещено их изменение до восстановления синхронизации, то это CP система (CP система гарантирует консистентность данных при разделении). Если данные доступны, но не согласованы, то это AP система (При разделении гарантируется доступность данных).  
Комментарий 4:  
"А что думаете по поводу возможных вариантов классификации такой системы по PACELC?"
Если система гарантирует доступность данных при разделении, то по PACELC это система PA/EL система. Если система гарантирует консистентность данных, то это PC/EC система (Исходя из требования сохранить консистентность данных, жертвую доступность данных).  
Комментарий 5:
"Как думаете, возможны ли в рамках условия задачи и остальные варианты типа PA/EC, PC/EL?"  
PC/EL - В общем случае да, т.к. при разделении система фокусируется на консистентности данных. Однако при разделении система может гарантировать доступность данных при определённых настройках.  
PA/EC - В общем случае да. При разделении системы ставка делается на доступность, а при отсутствии распределения – на консистентность. 
* Система может не прислать корректный ответ или сбросить соединение - По CAP теореме это CP система, по PACELC это PC/EC система.

# Задача 3
Могут ли в одной системе сочетаться принципы BASE и ACID? Почему?  
Нет. Эти принципы противорачат друг другу.  
BASE - высокая производительность систем. Эти принципы гарантируют что система ответит на запрос, но данные могут быть не актуальными.  
ACID - высокая надёжность систем. ACID принципы гарантируют что транзакции буду успешно завершены.  

# Задача 4
Key-Value система с поддержкой Pub/Sub - это redis.
Минусы:
Не встроенного кластерного решения. Необходимо дополнительно настраивать Redis Sentinel.
По умолчанию данные хранятся в оперативной памяти, в случае аварии данные после последней синхронизации с диском будут потеряны.
Нет поддержки языка SQL.
