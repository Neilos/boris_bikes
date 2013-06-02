require_relative 'bike'
require_relative 'dockable'

class Headquarters
  attr_reader :dockables

   def initialize
     @dockables = []
   end

  def all_docked_bikes(specified_state=nil)
    @dockables.map {|dockable| dockable.bikes(specified_state)}.flatten
  end

  def register_dockable(new_dockable)
     dockables << new_dockable
     true
  end

  
end