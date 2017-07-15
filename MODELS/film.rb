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

  def update( new_params )
    @name = new_params[ 'name' ] if new_params[ 'name' ]
    @price = new_params[ 'price' ].to_f() if new_params[ 'price' ]
    sql = "UPDATE films SET ( title, price ) = ( '#{@title}', #{@price} ) WHERE id = #{@id};"
    SqlRunner.run( sql )
  end

  def delete()
    sql = "DELETE FROM films WHERE id = #{@id};"
    SqlRunner.run( sql )
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
    sql = "DELETE FROM films;"
    SqlRunner.run( sql )
  end

  def self.map_items( sql )
    films = SqlRunner.run( sql )
    result = films.map { |film| Film.new( film ) }
    return result
  end

end
