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

  def redistribute

  end

end