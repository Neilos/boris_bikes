require 'minitest/spec'
require 'minitest/autorun'
require '../lib/van'
require '../lib/garage'
require '../lib/docking_station'
require '../lib/bike'

describe Van do

  before do
    @van = Van.new
    @docking_station1 = DockingStation.new
    @docking_station2 = DockingStation.new
    @garage = Garage.new
    @bike1 = Bike.new(1)
  end

  it "should be a dockable" do
    @van.must_be_kind_of Dockable
  end

  describe "collect" do
    it "should undock bikes from a specified dockable" do
      @docking_station1.dock(@bike1)
      @van.collect(@docking_station1,@bike1)
      @docking_station1.bikes.wont_include @bike1
    end

    it "should dock bikes into the van" do
      @docking_station1.dock(@bike1)
      @van.collect(@docking_station1,@bike1)
      @van.bikes.must_include @bike1
    end
  end

  describe "drop_off" do
    it "should undock bikes from the van" do
      @van.dock(@bike1)
      @van.drop_off(@docking_station1,@bike1)
      @van.bikes.wont_include @bike1
    end

    it "should dock bikes to a specified dockable" do
      @van.dock(@bike1)
      @van.drop_off(@docking_station1,@bike1)
      @docking_station1.bikes.must_include @bike1
    end
  end

  describe "redistribute" do
    it "should respond to redistribute" do
      @van.must_respond_to :redistribute
    end

    it "should calculate the docking_station with the highest number of bikes" do
      
    end
    # describe "transfer broken bikes to a garage" do
    #   it "should collect bikes from a dockable and drop-off some or all at another dockable" do

    #   end

    #   it "should only drop_off at a garage" do
    #     # lambda { ??????????) }.must_raise RuntimeError
    #   end
    # end

    # describe "transfer fixed bikes to a docking station" do
    #   it "should only collect from a garage" do
    #     skip
    #     # lambda { ????????????) }.must_raise RuntimeError
    #   end

    #   it "should only drop_off at a docking station" do
    #     skip
    #     # lambda { ????????????) }.must_raise RuntimeError
    #   end
    # end

    # describe "transfer excess bikes from one docking station to another" do
    #   it "should only collect from a docking_station" do
    #     skip
    #     # lambda { ????????????) }.must_raise RuntimeError
    #   end

    #   it "should only drop_off at a docking station" do
    #     skip
    #     # lambda { ????????????) }.must_raise RuntimeError
    #   end
    # end
  end





end