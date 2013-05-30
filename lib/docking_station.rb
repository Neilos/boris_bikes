require_relative 'dockable.rb'
require_relative 'headquarters'

class DockingStation
  include Dockable

  def initialize(hq)
    set_hunger_for(Bike::BROKEN => -1)
    set_hunger_for(Bike::WORKING => 1)
    headquarters = hq
  end

  def break(bike)
    bike.break!
  end


end