
# Bike knows and can change it's state
class Bike
  attr_reader :id
  attr_accessor :state

  STATES = [
    BROKEN = :broken,
    WORKING = :working
  ]

  def initialize(id)
    self.state = WORKING
    @id = id
  end

  def break!
    self.state = BROKEN
    self
  end

  def fix!
    self.state = WORKING
    self
  end
end