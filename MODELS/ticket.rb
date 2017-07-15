require_relative( '../DB/sql_runner.rb' )

class Ticket

  def initialize( params )
    @id = params[ 'id' ].to_i() if params[ 'id' ]
    @customer_id = params[ 'customer_id' ].to_i()
    @film_id = params[ 'film_id' ].to_i()
  end

  def save()

    

  end

end