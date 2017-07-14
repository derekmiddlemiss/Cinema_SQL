require_relative( '../DB/sql_runner.rb' )

def Film

  attr_reader :id, :title, :price

  def initialize( params )
    @id = params[ 'id' ].to_i() if params[ 'id' ]
    @title = params[ 'title' ]
    @price = params[ 'price' ].to_f()
  end

end
