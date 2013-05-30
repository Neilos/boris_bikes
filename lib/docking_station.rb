require_relative 'dockable.rb'

class DockingStation
  include Dockable

  def initialize
    set_hunger_for(Bike::BROKEN => -1)
    set_hunger_for(Bike::WORKING => 1)
  end

  def break(bike)
    bike.break!
  end


end