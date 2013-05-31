
class Bike


  BIKE_TYPES = [
    BROKEN = :broken,
    WORKING = :working
  ]

  attr_reader :id

  def initialize(id)
    fix!
    @id = id
    @broken = false
  end

  def broken?
    @broken
  end

  def break!
    @broken = true
    self
  end

  def fix!
    @broken = false
    self
  end
end