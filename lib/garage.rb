require_relative 'dockable.rb'
require_relative 'headquarters'
require_relative 'bike'

# A Garage is a Dockable that fixes bikes that are docked with it
class Garage
  include Dockable
  
  def initialize(headquarters)
    self.headquarters = headquarters
    # set_hunger_for(Bike::BROKEN => 1)
    # set_hunger_for(Bike::WORKING => -1)
  end

  # alias :fixed_bikes :bikes(Bike::WORKING)

  def fix(bike)
    bike.state = Bike::WORKING
  end

end