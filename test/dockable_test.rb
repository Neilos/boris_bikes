require 'minitest/autorun'
require 'minitest/spec'
require '../lib/dockable'
require '../lib/bike'

class DockableClass
  include Dockable # only need to include the module to get all the functionality

  def initialize
    #do whatever we like here
  end

end

describe Dockable do

  before do
    @dockable_instance = DockableClass.new
    @bike1 = Bike.new(1)
    @bike2 = Bike.new(2)
    @bike3 = Bike.new(3)
    @bike4 = Bike.new(4)
  end

  it "should have an id of integer" do
    @dockable_instance.id = 2
    @dockable_instance.id.must_be_kind_of(Integer)
  end

  describe "bike count" do

    it "should count the number of bikes docked" do
      @dockable_instance.bikes_count.must_be_kind_of(Integer)
    end

    it "should return a zero bike count for a new instance" do
      @dockable_instance.bikes_count.must_equal 0
    end

  end

  it "should be empty when the count of bikes is 0" do
    @dockable_instance.must_be :empty?
  end

  describe "capacity" do

    it "should be retrievable" do
      @dockable_instance.must_respond_to :capacity
    end

    it "should be settable" do
      @dockable_instance.must_respond_to :capacity= 
    end

    it "should return a default value of 10" do
      @dockable_instance.capacity.must_equal 10
    end

    it "should retain the set capacity" do
      set_value = 20
      @dockable_instance.capacity = set_value
      @dockable_instance.capacity.must_equal set_value
    end

  end

  it "should be full when bike count is equal to capacity" do
    @dockable_instance.capacity=(1)
    @dockable_instance.dock(@bike1)
    @dockable_instance.must_be :full?
  end

  describe "docking bikes" do
      
    it "should be able to dock a bike" do
      @dockable_instance.dock(@bike1)
      @dockable_instance.bikes_count.must_equal 1
    end

    describe "invalid docks" do

      it "should not dock a bike that is already docked" do
        @dockable_instance.dock(@bike1)
        lambda { @dockable_instance.dock(@bike1) }.must_raise RuntimeError
      end

      it "should return true if bike docked successfully" do
        
      end

      it "should give a suitable error message when trying to add a bike that is already docked" do
        @dockable_instance.dock(@bike1)
        begin
          @dockable_instance.dock(@bike1)
        rescue RuntimeError => e
          e.message.must_equal "Bike with id #{@bike1.id} is already docked"
        end
      end
    end

    describe "docking when full" do
      
      before do
        @dockable_instance.capacity=(1)
        @dockable_instance.dock(@bike1)
      end

      it "must not dock if dockable is full" do      
        lambda { @dockable_instance.dock(@bike1) }.must_raise RuntimeError
      end

      it "should return a useful error message" do
        begin
          @dockable_instance.dock(@bike1)
        rescue RuntimeError => e
          e.message.must_equal "Maximum capacity reached. Cannot dock another bike."
        end
      end
    end
  end

  describe "undocking bikes" do

    before do
      @dockable_instance.dock(@bike1)
      @dockable_instance.dock(@bike2)
      @dockable_instance.dock(@bike3)
      @dockable_instance.dock(@bike4)
      @undocked_bike = Bike.new(333)
    end

    it "should return the FIFO bike when no bike is specified" do
      @dockable_instance.undock.must_equal @bike1
    end

    it "should return a particular bike if specified" do
      @dockable_instance.undock(@bike2).must_equal @bike2
    end

    it "should return nil if a specific requested bike is not docked" do
      @dockable_instance.undock(@undocked_bike).must_equal nil
    end

    it "should not undock multiple bikes" do
      lambda { @dockable_instance.undock(@bike1, @bike2) }.must_raise ArgumentError
    end

    it "should not undock multiple bikes" do
      begin
        @dockable_instance.undock(@bike1, @bike2)
      rescue ArgumentError => e
        e.message.must_equal "Cannot undock multiple bikes at once"
      end
    end

    describe "when empty" do
      before do
        @dockable_instance = DockableClass.new  # empty DockableClass instances
      end

      it "wont undock bikes if there are not enough bikes" do
        lambda { @dockable_instance.undock }.must_raise RuntimeError
      end

      it "should return a message indicating not enough bikes" do
        begin
          @dockable_instance.undock
        rescue RuntimeError => e
          e.message.must_equal "No more bikes."
        end
      end 
    end
  end

  describe "broken_bikes" do

    it "should return only the broken_bikes" do
      @broken_bike1 = Bike.new(1)
      @broken_bike1.break!
      
      @broken_bike2 = Bike.new(2)
      @broken_bike2.break!
      
      @dockable_instance.dock(@bike1)
      @dockable_instance.dock(@broken_bike1)
      @dockable_instance.dock(@bike2)
      @dockable_instance.dock(@broken_bike2)

      @dockable_instance.broken_bikes.must_equal [@broken_bike1, @broken_bike2]
    end

  end

  it "should return a list of available bikes" do
    ###### NEEDS MORE WORK ###############
  end

end
