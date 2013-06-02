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
    @dockable_instance = DockableClass.new
    @bike1 = Bike.new(1)
    @bike2 = Bike.new(2)
    @bike3 = Bike.new(3)
    @bike4 = Bike.new(4)
  end

  it "should be able to register with a headquarters" do
    @mock_hq = MiniTest::Mock.new
    @mock_hq.expect(:register_dockable, true, [DockableClass])
    @dockable_instance.register_with_hq(@mock_hq)
    @mock_hq.verify
  end

  it "should know its headquarters at all times" do
    @dockable_instance.headquarters.wont_be_nil
  end

  it "should have a hunger_monitor" do
    @dockable_instance.must_respond_to :hunger_monitor
    @dockable_instance.must_respond_to :hunger_monitor=
  end

  it "should be able to set a hunger_monitor" do
    @mock_hunger_monitor = MiniTest::Mock.new
    @dockable_instance.hunger_monitor = @mock_hunger_monitor
  end

  it "should know its hunger_monitor at all times" do
    @dockable_instance.headquarters.wont_be_nil
  end

  it "should have an id of integer" do
    @dockable_instance.id = 2
    @dockable_instance.id.must_be_kind_of(Integer)
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


  describe "docking bikes" do      
    it "should be able to dock a bike" do
      @dockable_instance.dock(@bike1)
    end


    describe "invalid docks" do
      it "should not dock a bike that is already docked" do
        @dockable_instance.dock(@bike1)
        lambda { @dockable_instance.dock(@bike1) }.must_raise RuntimeError
      end

      it "should return the bike if bike docked successfully" do
        @dockable_instance.dock(@bike1).must_equal @bike1
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


  describe "bikes" do
    it "should return a list of all docked bikes WHEN no argument is specified" do
      @dockable_instance.dock(@bike1)
      @dockable_instance.dock(@bike2)
      @dockable_instance.bikes.must_equal [@bike1, @bike2]
    end

    it "should return a list of bikes of a specified state when specified" do
      @dockable_instance.dock(@bike1)
      @dockable_instance.dock(@bike2)
      @dockable_instance.dock(@bike3.break!)
      @dockable_instance.bikes(Bike::WORKING).must_equal [@bike1, @bike2]
    end

    it "should NOT be possible to add bikes without docking them" do
      @dockable_instance.dock(@bike1)
      @dockable_instance.dock(@bike2)
      @dockable_instance.bikes << @bike3
      @dockable_instance.bikes.must_equal [@bike1, @bike2]
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

    it "should NOT be possible to remove bikes without undocking them" do
      @dockable_instance.bikes.pop
      @dockable_instance.bikes.must_equal [@bike1, @bike2, @bike3, @bike4]
    end


    describe "undocking when empty" do
      before do
        @empty_dockable_instance = DockableClass.new  # empty DockableClass instances
      end

      it "wont undock bikes if there are not enough bikes" do
        lambda { @empty_dockable_instance.undock }.must_raise RuntimeError
      end

      it "should return a message indicating not enough bikes" do
        begin
          @empty_dockable_instance.undock
        rescue RuntimeError => e
          e.message.must_equal "No more bikes."
        end
      end 
    end
  end


  describe "bike count" do
    it "should count the total number of bikes docked WHEN a particular bike type is NOT specified" do
      @dockable_instance.count_bikes.must_be_kind_of(Integer)
    end

    it "should return a zero bike count for a new instance" do
      @dockable_instance.count_bikes.must_equal 0
    end

    it "should count only bikes of a particular type when bike type is specified" do
      @dockable_instance.dock(@bike1)
      @dockable_instance.dock(@bike2.break!)
      @dockable_instance.count_bikes(Bike::WORKING).must_equal 1
    end
  end


  it "should be full when bike count is equal to capacity" do
    @dockable_instance.capacity=(1)
    @dockable_instance.dock(@bike1)
    @dockable_instance.full?.must_equal true
  end

  it "should be empty when the count of bikes is 0" do
    @dockable_instance.empty?.must_equal true
  end
  

  # describe "hunger levels" do
  #   it "should have a default value of 0" do
  #     @dockable_instance.get_hunger_for(Bike::BROKEN).must_equal 0
  #   end

  #   it "should have a set_hunger_for and a get_hunger_for methods that set and get the hunger level" do
  #     @dockable_instance.set_hunger_for(Bike::BROKEN => 1)
  #     @dockable_instance.get_hunger_for(Bike::BROKEN).must_equal 1
  #   end
  # end
end
