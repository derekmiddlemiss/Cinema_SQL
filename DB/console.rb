require( 'pry-byebug' )
require_relative( '../MODELS/customer.rb' )
require_relative( '../MODELS/film.rb' )

harrison_ford = Customer.new( {
  'name' => 'Harrison Ford',
  'funds' => 54
  } )
harrison_ford.save()

sigourney_weaver = Customer.new( {
  'name' => 'Sigourney Weaver',
  'funds' => 63.99
  } )
sigourney_weaver.save()

keanu_reeves = Customer.new( {
  'name' => 'Keanu Reeves',
  'funds' => 12.50
  } ) 
keanu_reeves.save()

hopefully_harrison_ford = Customer.find( harrison_ford.id )
harrison_ford.update( { 'name' => 'Harrison Fnord' } )

# binding.pry

harrison_ford.delete()
hopefully_not_harrison_ford = Customer.find( harrison_ford.id )
customers = Customer.list_all()

# binding.pry

Customer.delete_all()
customers = Customer.list_all()

# binding.pry

blade_runner = Film.new( {
  'title' => 'Blade Runner',
  'price' => 10.50
  } )
blade_runner.save()

interstellar = Film.new( {
  'title' => 'Interstellar',
  'price' => 9.50
  } )
interstellar.save()

the_big_lebowski = Film.new( {
  'title' => 'The Big Lebowski',
  'price' => 12.00
  } )
the_big_lebowski.save()

hopefully_interstellar = Film.find( interstellar.id )
the_big_lebowski.update( { 'price' => 11.50 } )

binding.pry

interstellar.delete()
hopefully_not_interstellar = Film.find( interstellar.id )
films = Film.list_all()

binding.pry

Film.delete_all()
films = Film.list_all()

binding.pry

nil 