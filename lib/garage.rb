require_relative 'dockable.rb'

class Garage
  include Dockable
  
  # alias :fixed_bikes :available_bikes

  def fix(bike)
    bike.fix!
  end


end