require 'minitest/spec'
require 'minitest/autorun'
require '../lib/garage'
require '../lib/bike'
require '../lib/headquarters'

describe Garage do 
  before do
    @garage = Garage.new(Headquarters.new)
    @bike = Bike.new(id:1)
    @broken_bike = Bike.new(id:2, chance_of_breaking:1).ride
  end

  it "should be initialized with a headquarters" do
    Garage.new(Headquarters.new)
  end

  it "should be able to fix bikes" do
    @garage.fix(@broken_bike)
    @broken_bike.state.wont_equal Bike::BROKEN
  end

  it "should be a dockable" do
    @garage.must_be_kind_of(Dockable)
  end

  # describe "hunger levels" do
  #   it "should have a hunger level greater than 0 for bike type Bike::BROKEN" do
  #     @garage.get_hunger_for(Bike::BROKEN).must_be(:>, 0)
  #   end

  #   it "should have a hunger level less than 0 for bike type Bike::WORKING" do
  #     @garage.get_hunger_for(Bike::WORKING).must_be(:<, 0)
  #   end
  # end

end
