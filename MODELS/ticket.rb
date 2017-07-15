require_relative( '../DB/sql_runner.rb' )

class Ticket

  attr_reader :id, :customer_id, :film_id

  def initialize( params )
    @id = params[ 'id' ].to_i() if params[ 'id' ]
    @customer_id = params[ 'customer_id' ].to_i()
    @film_id = params[ 'film_id' ].to_i()
  end

  def save?()
    # Check film and customer exist in db before save
    film_in_db = !Film.find( @film_id ).empty?()
    customer_in_db = !Customer.find( @customer_id ).empty?()

    if film_in_db && customer_in_db
      sql = "INSERT INTO tickets ( customer_id, film_id ) VALUES ( #{@customer_id}, #{@film_id} ) RETURNING id;"
      ticket = SqlRunner.run( sql ).first()
      @id = ticket[ 'id' ].to_i()
      return true
    else
      return false
    end

  end

  def update?( new_params )
    # Default is to change nothing
    new_customer_id = @customer_id
    new_film_id = @film_id
    customer_in_db = true
    film_in_db = true

    ticket_in_db = !Ticket.find( @id ).empty?()

    if new_params.has_key?( 'customer_id' )
      new_customer_id = new_params[ 'customer_id' ].to_i
      customer_in_db = !Customer.find( new_customer_id ).empty?()
    end

    if new_params.has_key?( 'film_id' )
      new_film_id = new_params[ 'film_id' ].to_i
      film_in_db = !Film.find( new_film_id ).empty?
    end

    if ticket_in_db && customer_in_db && film_in_db
        @customer_id = new_customer_id
        @film_id = new_film_id
        sql = "UPDATE tickets SET ( customer_id, film_id ) = ( #{@customer_id}, #{@film_id} ) WHERE id = #{@id};"
        SqlRunner.run( sql )
        return true
    else
      return false
    end

  end

  def delete?()
    ticket_in_db = !Ticket.find( @id ).empty?()
    if ticket_in_db
      sql = "DELETE FROM tickets WHERE id = #{@id};"
      SqlRunner.run( sql )
      return true
    else
      return false
    end
  end
  
  def self.find( search_id )
    sql = "SELECT * FROM tickets WHERE id = #{search_id};"
    return self.map_items( sql )
  end

  def self.list_all()
    sql = "SELECT * FROM tickets;"
    return self.map_items( sql )
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run( sql )
  end

  def self.map_items( sql )
    tickets = SqlRunner.run ( sql )
    result = tickets.map { |ticket| Ticket.new( ticket) }
    return result
  end
  
end