require_relative 'dockable.rb'

class Garage
  include Dockable
  
  def initialize
    set_hunger_for(Bike::BROKEN => 1)
    set_hunger_for(Bike::WORKING => -1)
  end

  # alias :fixed_bikes :available_bikes

  def fix(bike)
    bike.fix!
  end


end