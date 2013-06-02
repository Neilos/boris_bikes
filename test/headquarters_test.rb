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

  describe "all_docked_bikes" do
    before do
      @faultless_bike1 = Bike.new(id:1,chance_of_breaking:0).ride
      @faultless_bike2 = Bike.new(id:2,chance_of_breaking:0).ride
      @faultless_bike3 = Bike.new(id:3,chance_of_breaking:0).ride
      @duff_bike = Bike.new(id:4,chance_of_breaking:1.0).ride
    end

    it "should return a list of all docked bikes at registered dockables" do
      
      docking_station = DockingStation.new(@headquarters)
      unregistered_docking_station =DockingStation.new(Headquarters.new)
      garage = Garage.new(@headquarters)
      van = Van.new(@headquarters)

      docking_station.dock(@faultless_bike1)
      docking_station.dock(@faultless_bike2)
      garage.dock(@duff_bike)
      unregistered_docking_station.dock(@faultless_bike3)

      @headquarters.all_docked_bikes.must_equal [@faultless_bike1, @faultless_bike2, @duff_bike]
    end

    it "should return a list of all docked bikes of a specified type at registered dockables" do
      docking_station = DockingStation.new(@headquarters)
      unregistered_docking_station =DockingStation.new(Headquarters.new)
      garage = Garage.new(@headquarters)
      van = Van.new(@headquarters)

      docking_station.dock(@faultless_bike1)
      docking_station.dock(@faultless_bike2)
      garage.dock(@duff_bike)
      unregistered_docking_station.dock(@faultless_bike1)

      @headquarters.all_docked_bikes(Bike::WORKING).must_equal [@faultless_bike1, @faultless_bike2]
    end
  end
end