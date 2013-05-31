require 'minitest/autorun'
require '../lib/bike'
require 'minitest/spec'

describe Bike do 

  before do
    @bike = Bike.new(1)
  end

  it "should have a defined constant of BROKEN" do
    defined?(Bike::BROKEN).wont_be_nil
  end

  it "should have a defined constant of WORKING" do
    defined?(Bike::WORKING).wont_be_nil
  end

  describe "BIKE_TYPES" do

    it "should have an array of constants called BIKE_TYPES" do
      defined?(Bike::BIKE_TYPES).wont_be_nil
    end

    it "should include the bike type WORKING" do
      Bike::BIKE_TYPES.include?(Bike::WORKING).wont_equal false
    end

    it "should include the bike type BROKEN" do
      Bike::BIKE_TYPES.include?(Bike::BROKEN).wont_equal false
    end

  end

  it "should have an id" do
    @bike.id.wont_be_nil
  end

  it "should not be broken when initialized" do
    @bike.broken?.wont_equal true
  end
  
  describe "break!" do
    it "should be broken when broken" do
      @bike.break!
      @bike.broken?.must_equal true
    end

    it "should return a reference to the bike" do
      @bike.break!.must_be_same_as @bike
    end
  end
  
  describe "fix!" do
    it "should not be broken when fixed" do
      @bike.break!
      @bike.fix!
      @bike.broken?.wont_equal true
    end

    it "should return a reference to the bike" do
      @bike.fix!.must_be_same_as @bike
    end
  end

end