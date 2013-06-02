require 'minitest/spec'
require 'minitest/autorun'
require '../lib/bike'


describe Bike do 

  before do
    @bike = Bike.new
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

  it "should know its chance_of_breaking" do
    @bike.must_respond_to :chance_of_breaking
  end

  
  describe "initialization" do
    it "should have an id that can be set when initialized" do
      new_bike = Bike.new(id: 1)
      new_bike.id.wont_be_nil
    end

    it "should not be broken when initialized" do
      new_bike = Bike.new
      new_bike.state.wont_equal Bike::BROKEN
    end

    it "should be initializable with a chance of breaking" do
      new_bike = Bike.new(chance_of_breaking: 0.7)
      new_bike.chance_of_breaking.must_equal 0.7
    end
  end


  it "should be possible to ride it" do
    @bike.must_respond_to :ride
  end

  it "should break when ridden depending on its chance_of_breaking" do
    faultless_bike = Bike.new(chance_of_breaking: 0.0)
    faultless_bike.ride
    faultless_bike.state.wont_equal Bike::BROKEN

    duff_bike = Bike.new(chance_of_breaking: 1.0)
    duff_bike.ride
    duff_bike.state.must_equal Bike::BROKEN
  end

end