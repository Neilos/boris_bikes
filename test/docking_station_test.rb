require 'minitest/spec'
require 'minitest/autorun'
require '../lib/docking_station'
require '../lib/bike'

describe DockingStation do 
  before do
    @docking_station = DockingStation.new
    @bike = Bike.new(1)
  end

  it "should be able to break bikes" do
    @docking_station.break(@bike)
    @bike.must_be :broken?
  end

  it "should be a dockable" do
    @docking_station.must_be_kind_of(Dockable)
  end
  
  describe "hunger levels" do
    it "should have a hunger level less than 0 for bike type Bike::BROKEN" do
      @docking_station.get_hunger_for(Bike::BROKEN).must_be(:<, 0)
    end

    it "should have a hunger level more than 0 for bike type Bike::WORKING" do
      @docking_station.get_hunger_for(Bike::WORKING).must_be(:>, 0)
    end
  end

end
