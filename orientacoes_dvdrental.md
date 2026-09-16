# Orientações para inicializar o banco `dvdrental`
## A. Iniciar o servidor
```
sudo service postgresql start
```

## B. Entrar no banco
```
psql -h 127.0.0.1 -U postgres
```

## C. Entrar no banco `dvdrental`
```
\c dvdrental
```