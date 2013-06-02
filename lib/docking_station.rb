require_relative 'dockable'
require_relative 'headquarters'

# DockingStations are basic dockables
class DockingStation
  include Dockable

  def initialize(headquarters)
    self.headquarters = headquarters
    # set_hunger_for(Bike::BROKEN => -1)
    # set_hunger_for(Bike::WORKING => 1)
  end

end