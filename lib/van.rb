require_relative '../lib/dockable'

class Van
  include Dockable

  def collect(dockable,*bikes)
    bikes.each do |bike|
      dockable.undock(bike) 
      dock(bike)
    end
  end

  def drop_off(dockable, *bikes)
    bikes.each do |bike|
      undock(bike)
      dockable.dock(bike)
    end
  end

  # ########### EXPERIMENTAL SPIKE ###########
  def redistribute
  #   # STEP 1
  #   # Call the most_hungry method to
  #   # find the most hungry dockable and what bike_type it is hungry for

  #   # STEP 2
  #   # Call the most_full_of method to
  #   # find out the dockable that is most full of the bike_type that 
  #   # the most hungry dockable is hungry for

  #   # STEP 3
  #   # determine the right number of bikes to be collected ??????
  #   # collect the right number of bikes of the right bike_type

  #   # STEP 4
  #   # determine the right number (??????????) of bikes 
  #   # of the right type to be 
  #   # dropped off at the most hungry dockable 
  #   # drop_off bikes

  end

  # def most_hungry
  #   # loop through all bike types calling most_hungry_for for each to
  #   # find both the most hungry dockable and what bike_type it is hungry for
  #   # return { most_hungry_dockable => ?, hungry_for => ? , number_desired => ?}
  # end

  def most_hungry_for(bike_type)
  #   # loop through all dockables
  #   # check each dockable for it's hunger level 
  #   # by calling the how_hungry_for method
  #   # return the dockable that is most hungry for the bike_type
    
  end
   
    def how_hungry_for(dockable, bike_type)
    #   # Calculate how hungry the given dockable is for the given bike_type
    #   # return the dockable's hunger_level for the given bike_type
    #   # multiplied by the count of the number of empty spaces it has
    #   # divided by the total capacity (i.e. a percentage)
      dockable.get_hunger_for(bike_type) * (dockable.capacity - dockable.bikes_count)
    end

  # def most_full_of(bike_type)
  #   # loop through all dockables
  #   # check each dockable for how full of the given bike_type it is
  #   # by calling the how_full_of method
  #   # return the dockable that is most full of (i.e. lowest result
  #   # from how_full_iof) the bike_type
  # end

  # def how_full_of(dockable, bike_type)
  #   # Calculate how full of the given bike_type
  #   # the given dockable is 
  #   # return the dockable's hunger_level for the given bike_type
  #   # multiplied by the count of the number of bikes of that bike_type it has
  #   # divided by the total capacity (i.e. a percentage)
  # end
  # ########### EXPERIMENTAL SPIKE ###########

end