require( 'pry-byebug' )
require_relative( '../MODELS/customer.rb' )
require_relative( '../MODELS/film.rb' )
require_relative( '../MODELS/ticket.rb' )

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

# hopefully_harrison_ford = Customer.find( harrison_ford.id )
# hf_updated = harrison_ford.update?( { 'name' => 'Harrison Fnord' } )

# # binding.pry

# hf_deleted = harrison_ford.delete?()
# hopefully_not_harrison_ford = Customer.find( harrison_ford.id )
# hf_deleted_again = harrison_ford.delete?()
# customers = Customer.list_all()

# # binding.pry

# Customer.delete_all()
# customers = Customer.list_all()

# # binding.pry

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

# hopefully_interstellar = Film.find( interstellar.id )
# tbl_updated = the_big_lebowski.update?( { 'price' => 11.50 } )

# # binding.pry

# i_deleted = interstellar.delete?()
# hopefully_not_interstellar = Film.find( interstellar.id )
# films = Film.list_all()

# # binding.pry

# Film.delete_all()
# films = Film.list_all()

# # binding.pry

ticket1 = Ticket.new( {
  'customer_id' => harrison_ford.id(),
  'film_id' => blade_runner.id()
  } )
t1_saved = ticket1.save?()

# binding.pry

# t1_updated__true = ticket1.update?( {'customer_id' => keanu_reeves.id()} )

# # binding.pry

# t1_updated__false = ticket1.update?( {'customer_id' => keanu_reeves.id()+1} )

# binding.pry

ian_holm = Customer.new( {
  'name' => 'Ian Holm',
  'funds' => 12.50
  } )

t1_updated__false2 = ticket1.update?( {'customer_id' => ian_holm.id()} )

ian_holm.save()

ticket2 = Ticket.new( {
  'customer_id' => sigourney_weaver.id(),
  'film_id' => interstellar.id()
  } )
t2_saved = ticket2.save?()

tickets = Ticket.list_all()
hopefully_sw_at_i = Ticket.find( ticket2.id() )

binding.pry

nil 