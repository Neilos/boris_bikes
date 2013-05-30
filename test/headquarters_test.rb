require 'minitest/spec'
require 'minitest/autorun'
require '../lib/headquarters'
require '../lib/garage'
require '../lib/docking_station'
require '../lib/van'

describe Headquarters do

  before do
    @headquarters = Headquarters.new
  end

  it "should maintain and return a list of all dockables" do
    @headquarters.dockables.must_equal []
  end

  describe "creating dockables" do
    it "should create garages" do
      @headquarters.create(Garage).must_be_instance_of Garage
    end

    it "should create docking stations" do
      @headquarters.create(DockingStation).must_be_instance_of DockingStation
    end

    it "should create vans" do
      @headquarters.create(Van).must_be_instance_of Van
    end

    it "should keep a record of dockables created" do
      docking_station = @headquarters.create(DockingStation)
      @headquarters.dockables.must_include docking_station
    end
  end

  it "should return a list of all docked bikes" do
    @bike1 = Bike.new(1)
    @bike2 = Bike.new(2)
    @bike3 = Bike.new(3)
    
    @docking_station = @headquarters.create(DockingStation)
    @garage = @headquarters.create(Garage)
    @van = @headquarters.create(Van)

    @docking_station.dock(@bike1)
    @docking_station.dock(@bike2)
    @garage.dock(@bike3)

    @headquarters.all_docked_bikes.must_equal [@bike1, @bike2, @bike3]
  end

end