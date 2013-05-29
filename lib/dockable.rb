
module Dockable

  attr_accessor :id

  def available_bikes
    []
  end

  def dock(bike)
    raise RuntimeError, "Maximum capacity reached. Cannot dock another bike." if full?
    raise RuntimeError, "Bike with id #{bike.id} is already docked" if bikes.include? bike
    true if bikes << bike
  end
<<<<<<< HEAD

  # returns an array of bikes
  def undock(*bike_to_undock)
    raise ArgumentError, "Cannot undock multiple bikes at once" if bike_to_undock.length > 1
    raise RuntimeError, "No more bikes." if empty?

    if bike_to_undock.length ==0
      return bikes.shift
    else
      bikes.delete bike_to_undock.first
=======

  # returns an array of bikes
  def undock(*bike_to_undock)
    raise ArgumentError, "Cannot undock multiple bikes at once" if bike_to_undock.length > 1
    raise RuntimeError, "No more bikes." if empty?

    if bike_to_undock.length ==0
      return bikes.shift
    else
      found = bikes.index(bike_to_undock[0])
      bikes.delete_at(found) unless found.nil?
>>>>>>> 186c9d5f0012188d1bf595d937f208c483548ee7
    end
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
    return @capacity || capacity=(10)
  end

  def capacity=(capacity)
    @capacity = capacity
  end

  def broken_bikes
    bikes.select { |bike| bike.broken? }
  end
end