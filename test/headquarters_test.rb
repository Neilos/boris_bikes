require 'minitest/spec'
require 'minitest/autorun'
require '../lib/headquarters'
require '../lib/garage'
require '../lib/docking_station'
require '../lib/van'

class DockableClass
  include Dockable

  def initialize(hq)
    headquarters = hq
  end
end

describe Headquarters do

  before do
    @headquarters = Headquarters.new
  end

  it "should register_dockables" do
    @docking_station = DockingStation.new(@headquarters)
    @headquarters.dockables.must_include @docking_station
  end

  it "should maintain and return a list of all dockables" do
    @headquarters.dockables.must_equal []
  end

  it "should return a list of all docked bikes" do
    @bike1 = Bike.new(1)
    @bike2 = Bike.new(2)
    @bike3 = Bike.new(3)
    
    @docking_station = DockingStation.new(@headquarters)
    @garage = Garage.new(@headquarters)
    @van = Van.new(@headquarters)

    @docking_station.dock(@bike1)
    @docking_station.dock(@bike2)
    @garage.dock(@bike3)

    @headquarters.all_docked_bikes.must_equal [@bike1, @bike2, @bike3]
  end

end