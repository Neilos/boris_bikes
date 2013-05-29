
module Dockable

  attr_accessor :id

  def available_bikes
    []
  end

  def dock(bike)

  end

  def bikes
    @bikes ||= []
  end

  def bikes_count
    bikes.count
  end

end