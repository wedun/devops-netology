## Задача 1
Найдите, где перечислены все доступные resource и data_source, приложите ссылку на эти строки в коде на гитхабе.  
resource: [resource](https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/provider.go#L411)  
data_source: [data_source](https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/provider.go#L169)  

С каким другим параметром конфликтует name? Приложите строчку кода, в которой это указано.  
Конфликтует с параметром name_prefix [name_prefix](https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/resource_aws_sqs_queue.go#L56)  

Какая максимальная длина имени?  
Максимальная длина 80 символов [ссылка](https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/validators.go#L1037)  

Какому регулярному выражению должно подчиняться имя?  
Регулярное выражении для имени: 
`^[0-9A-Za-z-_]+(\.fifo)?$` [ссылка](https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/validators.go#L1041)  
`^[0-9A-Za-z-_]+$` [ссылка](https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/validators.go#L1054)  
`^[0-9A-Za-z-_.]+$`[ссылка](https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/validators.go#L1068)  
`^[^a-zA-Z0-9-_]`[ссылка](https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/validators.go#L1072)  