require 'minitest/autorun'
require '../lib/bike'
require 'minitest/spec'

describe Bike do 

  before do
    @bike = Bike.new(1)
  end

  it "should have an id" do
    @bike.id.wont_be_nil
  end

  it "should not be broken when initialized" do
    @bike.wont_be :broken?
  end
  
  describe "break!" do
    it "should be broken when broken" do
      @bike.break!
      @bike.must_be :broken?
    end

    it "should return a reference to the bike" do
      @bike.break!.must_be_same_as @bike
    end
  end
  
  describe "fix!" do
    it "should not be broken when fixed" do
      @bike.break!
      @bike.fix!
      @bike.wont_be :broken?
    end

    it "should return a reference to the bike" do
      @bike.fix!.must_be_same_as @bike
    end
  end

end