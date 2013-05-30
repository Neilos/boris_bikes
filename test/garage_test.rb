require 'minitest/spec'
require 'minitest/autorun'
require '../lib/garage'
require '../lib/bike'

describe Garage do 
  before do
    @garage = Garage.new
    @bike = Bike.new(1)
    @broken_bike = Bike.new(2).break!
  end

  it "should be able to fix bikes" do
    @bike.break!
    @garage.fix(@bike)
    @bike.wont_be :broken?
  end

  it "should be a dockable" do
    @garage.must_be_kind_of(Dockable)
  end


  # describe "fixed_bikes" do
  #   it "should respond to fixed_bikes" do
  #     @garage.must_respond_to :fixed_bikes
  #   end

  #   it "should return only available_bikes" do
  #     @garage.dock(@bike)
  #     @garage.dock(@broken_bike)
  #     @garage.fixed_bikes.must_equal(@garage.available_bikes)
  #   end
  # end
end
