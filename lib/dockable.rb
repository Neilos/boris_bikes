
module Dockable

  DEFAULT_CAPACITY = 10

  attr_accessor :id
  attr_writer :capacity
  attr_reader :headquarters

  def register_with_hq(hq)
    @headquarters = hq            
    @headquarters.register_dockable(self)
  end

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

  def hunger_hash
   @hunger_hash ||= {}
  end

  # positive hunger levels indicate "hungry for"
  # negative hunger levels indicate "satisfied with"
  # so, for example, a garage will be naturally "satisfied with" available bikes
  # and "hungry for" broken bikes
  # hunger_level is a hash with Bike::'type' as the key and the hunger level
  # as the value
  def set_hunger_for(hunger_level)
     hunger_hash.merge!(hunger_level)
  end

  def get_hunger_for(bike_type)
     return hunger_hash[bike_type] unless hunger_hash[bike_type].nil?
     0
  end

end