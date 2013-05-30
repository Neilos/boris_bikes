
class Bike

  BROKEN = :broken
  WORKING = :working

  attr_reader :id

  def initialize(id)
    fix!
    @id = id
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