# Beetrack-challenge-javier-ruiz

## Development setup

* `touch .env`
* `docker-compose build`
* `docker-compose run --rm web bundle install`
* `docker-compose run --rm web yarn install`
* `docker-compose run --rm web rails db:create db:schema:load`
* `docker-compose up -d`
* Abrir `localhost:3000` en cualquier navegador

### Development tips

* Arreglar las ofensas de rubocop: `docker-compose exec web rubocop -a`
* Correr tests: `docker-compose exec web bundle exec rspec`

### Notas
- El link de heroku es [https://https://beetrack-challenge-javier-ruiz.herokuapp.com](https://https://beetrack-challenge-javier-ruiz.herokuapp.com)
- Se separó la API en dos controladores, uno para JSON y uno para HTML por simplicidad de código
- Se usó JS puro en el HTML para evitar programar de más, pero si se quisiera escalar se podrían crear componentes en Vue.js o React
- Si no se quiere usar docker se puede hacer con `ruby 2.7.1`
- Para lo documentación se copió un HTML generado por swagger
