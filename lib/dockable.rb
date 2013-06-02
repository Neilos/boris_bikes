
# Being a Dockable enables a class to dock and undock things
# Dockables have a hunger_monitor
# Dockables belong to a head_quarters

module Dockable 
  attr_accessor :id
  attr_writer :capacity, :hunger_monitor
  DEFAULT_CAPACITY = 10

  def capacity
    @capacity ||= DEFAULT_CAPACITY
  end

  def headquarters=(headquarters)
    @headquarters = headquarters
    @headquarters.register_dockable(self)
  end

  def headquarters
    @headquarters ||= Headquarters.new.register_dockable(self)
  end

  def hunger_monitor
    @hunger_monitor ||= Hunger_monitor.new
  end

  def docked_bikes(specified_state=nil)
    @docked_bikes ||= []
    return @docked_bikes unless specified_state
    @docked_bikes.select { |bike| bike.state == specified_state }
  end
  private :docked_bikes

  def bikes(specified_state=nil)
    docked_bikes(specified_state).dup
  end

  def count_bikes(specified_state=nil)
    docked_bikes(specified_state).count
  end

  def empty?
    count_bikes == 0
  end

  def full?
    count_bikes == capacity
  end

  def dock(bike)
    raise RuntimeError, "Maximum capacity reached. Cannot dock another bike." if full?
    raise RuntimeError, "Bike with id #{bike.id} is already docked" if docked_bikes.include? bike
    bike if docked_bikes << bike
  end

  # returns an array of docked_bikes
  def undock(bike_to_undock = nil)
    raise RuntimeError, "No more bikes." if empty?
    return docked_bikes.shift unless bike_to_undock
    docked_bikes.delete bike_to_undock
  end

  def broken_bikes
    bikes.select { |bike| bike.state }
  end

  def available_bikes
    bikes.reject { |bike| bike.broken? }
  end

  # def hunger_hash
  #  @hunger_hash ||= {}
  # end

  # # positive hunger levels indicate "hungry for"
  # # negative hunger levels indicate "satisfied with"
  # # so, for example, a garage will be naturally "satisfied with" available bikes
  # # and "hungry for" broken bikes
  # # hunger_level is a hash with Bike::'type' as the key and the hunger level
  # # as the value
  # def set_hunger_for(hunger_level)
  #    hunger_hash.merge!(hunger_level)
  # end

  # def get_hunger_for(bike_type)
  #    return hunger_hash[bike_type] unless hunger_hash[bike_type].nil?
  #    0
  # end

end