# Projeto API TESTE

Exemplo de uma api teste com documentação

# Project setup

Crie no diretório `config` o arquivo `database.yml`

```
# SQLite version 3.x
#   gem install sqlite3
#
#   Ensure the SQLite 3 gem is defined in your Gemfile
#   gem 'sqlite3'
#
default: &default
  adapter: sqlite3
  pool: 5
  timeout: 5000

development:
  <<: *default
  database: db/development.sqlite3

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *default
  database: db/test.sqlite3

production:
  <<: *default
  database: db/production.sqlite3

```

Execute os camandos para o banco de dados:

```
rake db:create
rake db:migrate
rake db:seed
```

Para rodar o projeto execute o comando:

```
rails s
```

Para criar a documentação da API executar os comandos:

```
rake docs:generate
```

Para abrir a documentação em seu navegador padrão utilize o comando(deve estar na pasta raiz do projeto):

```
open doc/api/index.html
```