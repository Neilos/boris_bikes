
class Bike

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
  end

  def fix!
    @broken = false
  end
end