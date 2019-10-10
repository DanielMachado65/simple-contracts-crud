# simple-contracts-crud

> is an application to use as backend for contract logic

A aplicação é uma aplicação basica de ruby on rails, construida com a infrestutura de __api__. Usando:

1. __Ruby on Ruby__: 5.2
2. __Active Storage__: para poder armazenar os arquivos
3. __Mysql__: banco de dados

Lógica de sessão foram feitas na mão, assim como a maioria de código. Foram utilizados poucos contrutores automaticos

## Rodando a aplicação

para rodar você vai precisar fazer:

```sh
# para criar a banco de dados
rake db:create

# para instalar as depedências
rake db:migrate

# para pegar as depedências
bundle install

# para executar
rails s -e development -b '0.0.0.0' -p 4000
```