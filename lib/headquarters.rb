require_relative 'bike'
require_relative 'dockable'

class Headquarters

attr_reader :dockables

   def initialize
     @dockables = []
   end

  def create(dockable_class)
    new_dockable = dockable_class.new
    dockables << new_dockable
    new_dockable
  end

  def all_docked_bikes
    @dockables.map {|dockable| dockable.bikes}.flatten
  end

  
end