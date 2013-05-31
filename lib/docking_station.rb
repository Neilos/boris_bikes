require_relative 'dockable'
require_relative 'headquarters'

class DockingStation
  include Dockable

  def initialize(headquarters)
    register_with_hq(headquarters)
    set_hunger_for(Bike::BROKEN => -1)
    set_hunger_for(Bike::WORKING => 1)
  end

  def break(bike)
    bike.break!
  end


end