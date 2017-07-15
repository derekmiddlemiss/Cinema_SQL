require_relative( '../DB/sql_runner.rb' )

class Customer

  attr_reader :id, :name, :funds

  def initialize( params )
    @id = params[ 'id' ].to_i() if params[ 'id' ]
    @name = params[ 'name' ]
    @funds = params[ 'funds' ].to_f()
  end

  def save()
    sql = "INSERT INTO customers ( name, funds ) VALUES ( '#{@name}', #{@funds} ) RETURNING id;"
    customer = SqlRunner.run( sql ).first()
    @id = customer[ 'id' ].to_i()
  end

  def update?( new_params )
    customer_in_db = !Customer.find( @id ).empty?()
    if customer_in_db

      @name = new_params[ 'name' ] if new_params[ 'name' ]
      @funds = new_params[ 'funds' ].to_f() if new_params[ 'funds' ]
      sql = "UPDATE customers SET ( name, funds ) = ( '#{@name}', #{@funds} ) WHERE id = #{@id};"
      SqlRunner.run( sql )
      return true

    else

      return false

    end
  end

  def buy_ticket( film )
    if @funds >= film.price()
      ticket = Ticket.new( {
        'customer_id' => @id,
        'film_id' => film.id()
        } )
      binding.pry
      if ticket.save?()
        @funds -= film.price()
        return true
      end
    else
      return false
    end
  end
      
  def delete?()
    customer_in_db = !Customer.find( @id ).empty?()
    if customer_in_db
      sql = "DELETE FROM customers WHERE id = #{@id};"
      SqlRunner.run( sql )
      return true
    else
      return false
    end
  end

  def films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets ON tickets.film_id = films.id
    WHERE tickets.customer_id = #{@id};"
    return Film.map_items( sql )
  end

  def self.find( search_id )
    sql = "SELECT * FROM customers WHERE id = #{search_id};"
    return self.map_items( sql )
  end

  def self.list_all()
    sql = "SELECT * FROM customers;"
    return self.map_items( sql )
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run( sql )
  end

  def self.map_items( sql )
    customers = SqlRunner.run( sql )
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end

end