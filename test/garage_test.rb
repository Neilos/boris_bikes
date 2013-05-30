require 'minitest/spec'
require 'minitest/autorun'
require '../lib/garage'
require '../lib/bike'
require '../lib/headquarters'

describe Garage do 
  before do
    @garage = Garage.new(Headquarters.new)
    @bike = Bike.new(1)
    @broken_bike = Bike.new(2).break!
  end

  it "should be initialized with a headquarters" do
    Garage.new(Headquarters.new)
  end

  it "should be able to fix bikes" do
    @bike.break!
    @garage.fix(@bike)
    @bike.broken?.must_equal false
  end

  it "should be a dockable" do
    @garage.must_be_kind_of(Dockable)
  end

  describe "hunger levels" do
    it "should have a hunger level greater than 0 for bike type Bike::BROKEN" do
      @garage.get_hunger_for(Bike::BROKEN).must_be(:>, 0)
    end

    it "should have a hunger level less than 0 for bike type Bike::WORKING" do
      @garage.get_hunger_for(Bike::WORKING).must_be(:<, 0)
    end
  end

end
