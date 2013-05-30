require_relative 'bike'
require_relative 'dockable'

class Headquarters

attr_reader :dockables

   def initialize
     @dockables = []
   end

  def all_docked_bikes
    @dockables.map {|dockable| dockable.bikes}.flatten
  end

  def register(headquarters, object)
     dockables << new_dockable
  end

  
end