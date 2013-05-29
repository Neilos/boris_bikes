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

end
