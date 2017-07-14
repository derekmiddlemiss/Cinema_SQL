require( 'pry-byebug' )
require_relative( '../MODELS/customer.rb' )

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
harrison_ford.delete()
hopefully_not_harrison_ford = Customer.find( harrison_ford.id )

customers = Customer.list_all

Customer.delete_all()

customers = Customer.list_all

binding.pry

nil 