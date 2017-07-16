require_relative( '../DB/sql_runner.rb' )

class Screening

  attr_reader :id, :time_and_date, :seats, :seats_sold, :film_id

  def initialize( params )
    @id = params[ 'id' ].to_i() if params[ 'id' ]
    @time_and_date = params[ 'time_and_date' ]
    @seats = params[ 'seats' ].to_i()
    @seats_sold = 0
    @film_id = params[ 'film_id' ].to_i()
  end

  def save?()
    # Check film exists in db
    film_in_db = !Film.find( @film_id ).empty?()
    if film_in_db
      sql = "INSERT INTO screenings ( time_and_date, seats, seats_sold, film_id ) VALUES ( '#{@time_and_date}', #{@seats}, #{@seats_sold}, #{@film_id} ) RETURNING id;"
      binding.pry
      result = SqlRunner.run( sql ).first()
      @id = result[ 'id' ].to_i()
      return true
    else
      return false
    end
  end

end

