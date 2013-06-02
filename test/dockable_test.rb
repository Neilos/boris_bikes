require 'minitest/spec'
require 'minitest/mock'
require 'minitest/autorun'
require '../lib/dockable'
require '../lib/bike'
require '../lib/headquarters'


class DockableClass
  include Dockable
end

class HeadquartersDouble
  def register_dockable(dockable)
  end
end

describe Dockable do

  before do
    @dockable = DockableClass.new
    @bike1 = Bike.new(id:1, chance_of_breaking: 0.8) #sometimes breaks when ridden
    @bike2 = Bike.new(id:2, chance_of_breaking: 0.8) #sometimes breaks when ridden
    @faultless_bike1 = Bike.new(id:3, chance_of_breaking: 0.0) #never breaks when ridden
    @faultless_bike2 = Bike.new(id:4, chance_of_breaking: 0.0) #never breaks when ridden
    @duff_bike1 = Bike.new(id:5, chance_of_breaking: 1.0) #always breaks when ridden
    @duff_bike2 = Bike.new(id:6, chance_of_breaking: 1.0) #always breaks when ridden
  end

  it "should be able to register with a headquarters" do
    @mock_hq = MiniTest::Mock.new
    @mock_hq.expect(:register_dockable, true, [DockableClass])
    @dockable.headquarters = @mock_hq
    @mock_hq.verify
  end

  it "should know its headquarters at all times" do
    @dockable.headquarters.wont_be_nil
  end

  it "should have a hunger_monitor" do
    @dockable.must_respond_to :hunger_monitor
    @dockable.must_respond_to :hunger_monitor=
  end

  it "should be able to set a hunger_monitor" do
    @mock_hunger_monitor = MiniTest::Mock.new
    @dockable.hunger_monitor = @mock_hunger_monitor
  end

  it "should know its hunger_monitor at all times" do
    @dockable.headquarters.wont_be_nil
  end

  it "should have an id of integer" do
    @dockable.id = 2
    @dockable.id.must_be_kind_of(Integer)
  end


  describe "capacity" do
    it "should be retrievable" do
      @dockable.must_respond_to :capacity
    end

    it "should be settable" do
      @dockable.must_respond_to :capacity= 
    end

    it "should return a default value of 10" do
      @dockable.capacity.must_equal 10
    end

    it "should retain the set capacity" do
      set_value = 20
      @dockable.capacity = set_value
      @dockable.capacity.must_equal set_value
    end
  end


  describe "docking bikes" do      
    it "should be able to dock a bike" do
      @dockable.dock(@bike1)
    end


    describe "invalid docks" do
      it "should not dock a bike that is already docked" do
        @dockable.dock(@bike1)
        lambda { @dockable.dock(@bike1) }.must_raise RuntimeError
      end

      it "should return the bike if bike docked successfully" do
        @dockable.dock(@bike1).must_equal @bike1
      end

      it "should give a suitable error message when trying to add a bike that is already docked" do
        @dockable.dock(@bike1)
        begin
          @dockable.dock(@bike1)
        rescue RuntimeError => e
          e.message.must_equal "Bike is already docked"
        end
      end
    end


    describe "docking when full" do
      before do
        @dockable.capacity=(1)
        @dockable.dock(@bike1)
      end

      it "must not dock if dockable is full" do      
        lambda { @dockable.dock(@bike1) }.must_raise RuntimeError
      end

      it "should return a useful error message" do
        begin
          @dockable.dock(@bike1)
        rescue RuntimeError => e
          e.message.must_equal "Maximum capacity reached. Cannot dock another bike."
        end
      end
    end
  end


  describe "bikes" do
    it "should return a list of all docked bikes WHEN no argument is specified" do
      @dockable.dock(@bike1)
      @dockable.dock(@bike2)
      @dockable.bikes.must_equal [@bike1, @bike2]
    end

    it "should return a list of bikes of a specified state when specified" do
      @dockable.dock(@bike1)
      @dockable.dock(@bike2)
      @duff_bike1.ride
      @dockable.dock(@duff_bike1)
      @dockable.bikes(Bike::WORKING).must_equal [@bike1, @bike2]
    end

    it "should NOT be possible to add bikes without docking them" do
      @dockable.dock(@bike1)
      @dockable.bikes << @bike2
      @dockable.bikes.must_equal [@bike1]
    end
  end


  describe "undocking bikes" do
    before do
      @dockable.dock(@bike1)
      @dockable.dock(@bike2)
    end

    it "should return the FIFO bike when no bike is specified" do
      @dockable.undock.must_equal @bike1
    end

    it "should return a particular bike if specified" do
      @dockable.undock(@bike2).must_equal @bike2
    end

    it "should return nil if a specific requested bike is not docked" do
      @dockable.undock(@faultless_bike2).must_equal nil
    end

    it "should return a bike even if no particular bike is specified" do
      @dockable.undock.wont_be_nil
    end

    it "should NOT be possible to remove bikes without undocking them" do
      @dockable.bikes.pop
      @dockable.bikes.must_equal [@bike1, @bike2]
    end


    describe "undocking when empty" do
      before do
        @empty_dockable = DockableClass.new  # empty DockableClass instances
      end

      it "wont undock bikes if there are not enough bikes" do
        lambda { @empty_dockable.undock }.must_raise RuntimeError
      end

      it "should return a message indicating not enough bikes" do
        begin
          @empty_dockable.undock
        rescue RuntimeError => e
          e.message.must_equal "No more bikes."
        end
      end 
    end
  end


  describe "bike count" do
    it "should count the total number of bikes docked WHEN a particular bike type is NOT specified" do
      @dockable.count_bikes.must_be_kind_of(Integer)
    end

    it "should return a zero bike count for a new instance" do
      @dockable.count_bikes.must_equal 0
    end

    it "should count only bikes of a particular type when bike type is specified" do
      @faultless_bike1.ride
      @dockable.dock(@faultless_bike1)
      @duff_bike1.ride
      @dockable.dock(@duff_bike1)
      @dockable.count_bikes(Bike::WORKING).must_equal 1
    end
  end


  it "should be full when bike count is equal to capacity" do
    @dockable.capacity=(1)
    @dockable.dock(@bike1)
    @dockable.full?.must_equal true
  end


  # describe "hunger levels" do
  #   it "should have a default value of 0" do
  #     @dockable.get_hunger_for(Bike::BROKEN).must_equal 0
  #   end

  #   it "should have a set_hunger_for and a get_hunger_for methods that set and get the hunger level" do
  #     @dockable.set_hunger_for(Bike::BROKEN => 1)
  #     @dockable.get_hunger_for(Bike::BROKEN).must_equal 1
  #   end
  # end
end
