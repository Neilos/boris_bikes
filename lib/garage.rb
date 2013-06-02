require_relative 'dockable.rb'
require_relative 'headquarters'

class Garage
  include Dockable
  
  def initialize(headquarters)
    self.headquarters = headquarters
    # set_hunger_for(Bike::BROKEN => 1)
    # set_hunger_for(Bike::WORKING => -1)
  end

  # alias :fixed_bikes :available_bikes

  def fix(bike)
    bike.fix!
  end


end