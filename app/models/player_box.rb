# fake object that only contains partial player information
class PlayerBox
  attr_reader :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end
end