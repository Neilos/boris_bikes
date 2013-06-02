require 'minitest/spec'
require 'minitest/autorun'
require '../lib/bike'


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

  describe "STATES" do
    it "should have an array of constants called STATES" do
      defined?(Bike::STATES).wont_be_nil
    end

    it "should include the bike type WORKING" do
      Bike::STATES.include?(Bike::WORKING).wont_equal false
    end

    it "should include the bike type BROKEN" do
      Bike::STATES.include?(Bike::BROKEN).wont_equal false
    end
  end

  it "should know its state" do
    @bike.must_respond_to :state
  end

  it "should have an id" do
    @bike.id.wont_be_nil
  end

  it "should not be broken when initialized" do
    @bike.state.wont_equal Bike::BROKEN
  end
  
  describe "break!" do
    it "should be broken when broken" do
      @bike.break!
      @bike.state.must_equal Bike::BROKEN
    end

    it "should return a reference to the bike" do
      @bike.break!.must_be_same_as @bike
    end
  end
  
  describe "fix!" do
    it "should not be broken when fixed" do
      @bike.break!
      @bike.fix!
      @bike.state.wont_equal Bike::BROKEN
    end

    it "should return a reference to the bike" do
      @bike.fix!.must_be_same_as @bike
    end
  end

end