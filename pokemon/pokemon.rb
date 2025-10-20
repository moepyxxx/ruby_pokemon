class Pokemon 
  attr_reader :name, :type, :moves

  def initialize(name, type, moves = [])
    @name = name
    @type = type
    @moves = moves
  end
end
