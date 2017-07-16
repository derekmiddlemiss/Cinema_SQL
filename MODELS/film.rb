require_relative( '../DB/sql_runner.rb' )

class Film

  attr_reader :id, :title, :price

  def initialize( params )
    @id = params[ 'id' ].to_i() if params[ 'id' ]
    @title = params[ 'title' ]
    @price = params[ 'price' ].to_f()
  end

  def save()
    sql = "INSERT INTO films ( title, price ) VALUES ( '#{@title}', #{@price} ) RETURNING id;"
    result = SqlRunner.run( sql ).first()
    @id = result[ 'id' ].to_i()
  end

  def update?( new_params )
    film_in_db = !Film.find( @id ).empty?()
    if film_in_db

      @name = new_params[ 'name' ] if new_params[ 'name' ]
      @price = new_params[ 'price' ].to_f() if new_params[ 'price' ]
      sql = "UPDATE films SET ( title, price ) = ( '#{@title}', #{@price} ) WHERE id = #{@id};"
      SqlRunner.run( sql )
      return true

    else

      return false

    end
  end

  def delete?()
    film_in_db = !Film.find( @id ).empty?()
    if film_in_db
      sql = "DELETE FROM tickets WHERE film_id = #{@id};"
      SqlRunner.run( sql )
      sql = "DELETE FROM films WHERE id = #{@id};"
      SqlRunner.run( sql )
      return true
    else
      return false
    end
  end

  def customers()
    sql = "SELECT customers.* FROM customers 
    INNER JOIN tickets ON tickets.customer_id = customers.id
    WHERE tickets.film_id = #{@id};"
    return Customer.map_items( sql )
  end

  def number_tickets()
    sql = "SELECT * FROM tickets WHERE film_id = #{@id};"
    return SqlRunner.run( sql ).count()
  end

  def self.find( search_id )
    sql = "SELECT * FROM films WHERE id = #{search_id};"
    return self.map_items( sql )
  end

  def self.list_all()
    sql = "SELECT * FROM films;"
    return self.map_items( sql )
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run( sql )
    sql = "DELETE FROM films;"
    SqlRunner.run( sql )
  end

  def self.map_items( sql )
    films = SqlRunner.run( sql )
    result = films.map { |film| Film.new( film ) }
    return result
  end

end
