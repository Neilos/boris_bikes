
# Bikes break randomly when ridden
class Bike
  attr_reader :id
  attr_accessor :state, :chance_of_breaking

  STATES = [
    BROKEN = :broken,
    WORKING = :working
  ]

  def initialize(characteristics={id: "?", chance_of_breaking: 0.5})
    self.state = WORKING
    @id = characteristics[:id]
    self.chance_of_breaking = characteristics[:chance_of_breaking]
  end

  def ride
    self.state = BROKEN if chance_of_breaking >= Random.rand
    self
  end

end