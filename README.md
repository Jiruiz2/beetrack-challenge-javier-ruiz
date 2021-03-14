# Beetrack-challenge-javier-ruiz

## Development setup

1. `touch .env`

* #### Si usas docker
  2. `docker-compose build`
  3. `docker-compose run --rm web rails db:create db:schema:load`
  4. `docker-compose up -d`

* #### Si tienes ruby 2.7.1
  2. `bundle install`
  3. `yarn install`
  4. `rails db:create db:schema:load`
  5. `rails s`
* Abrir `localhost:3000` en cualquier navegador

### Development tips

* Arreglar las ofensas de rubocop: `docker-compose exec web rubocop -a`
* Correr tests: `docker-compose exec web bundle exec rspec`

### Notas
- El link de heroku es [https://https://beetrack-challenge-javier-ruiz.herokuapp.com](https://https://beetrack-challenge-javier-ruiz.herokuapp.com)
- Se separó la API en dos controladores, uno para JSON y uno para HTML por simplicidad de código
- Se usó JS puro en el HTML para evitar programar de más, pero si se quisiera escalar se podrían crear componentes en Vue.js o React
- Para lo documentación se copió un HTML generado por swagger
- Dejé un script para probar los post a la api por si lo necesitan `populate_gps_waypoints.rb`
