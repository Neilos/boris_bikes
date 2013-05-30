
module Dockable

  DEFAULT_CAPACITY = 10

  attr_accessor :id
  attr_writer :capacity


  def dock(bike)
    raise RuntimeError, "Maximum capacity reached. Cannot dock another bike." if full?
    raise RuntimeError, "Bike with id #{bike.id} is already docked" if bikes.include? bike
    true if bikes << bike
  end

  # returns an array of bikes
  def undock(bike_to_undock = nil)
    raise RuntimeError, "No more bikes." if empty?
    return bikes.shift unless bike_to_undock
    bikes.delete bike_to_undock
  end

  def bikes
    @bikes ||= []
  end

  def bikes_count
    bikes.count
  end

  def empty?
    bikes_count == 0
  end

  def full?
    bikes_count == capacity
  end


  def capacity
    @capacity ||= DEFAULT_CAPACITY
  end


  def broken_bikes
    bikes.select { |bike| bike.broken? }
  end

  def available_bikes
    bikes.reject { |bike| bike.broken? }
  end

end