require 'minitest/spec'
require 'minitest/autorun'
require '../lib/van'
require '../lib/garage'
require '../lib/docking_station'
require '../lib/bike'
require '../lib/headquarters'

describe Van do

  before do
    @hq = Headquarters.new
    @van = Van.new(@hq)
    @docking_station1 = DockingStation.new(@hq)
    @docking_station2 = DockingStation.new(@hq)
    @garage1 = Garage.new(@hq)
    @faultless_bike1 = Bike.new(id:1, chance_of_breaking:0)
    @faultless_bike2 = Bike.new(id:2, chance_of_breaking:0)
    @faultless_bike3 = Bike.new(id:3, chance_of_breaking:0)
    @faultless_bike4 = Bike.new(id:4, chance_of_breaking:0)
    @duff_bike1 = Bike.new(id:5, chance_of_breaking:1.0)
    @duff_bike2 = Bike.new(id:6, chance_of_breaking:1.0)
    @duff_bike3 = Bike.new(id:7, chance_of_breaking:1.0)
    @duff_bike4 = Bike.new(id:8, chance_of_breaking:1.0)
  end

  it "should be initialized with a headquarters without any errors" do
    Van.new(Headquarters.new)
  end

  it "should be a dockable" do
    @van.must_be_kind_of Dockable
  end

  describe "collect" do
    it "should undock bikes from a specified dockable" do
      @docking_station1.dock(@faultless_bike1)
      @van.collect(@docking_station1,@faultless_bike1)
      @docking_station1.bikes.wont_include @faultless_bike1
    end

    it "should dock bikes into the van" do
      @docking_station1.dock(@faultless_bike1)
      @van.collect(@docking_station1,@faultless_bike1)
      @van.bikes.must_include @faultless_bike1
    end
  end

  describe "drop_off" do
    it "should undock bikes from the van" do
      @van.dock(@faultless_bike1)
      @van.drop_off(@docking_station1,@faultless_bike1)
      @van.bikes.wont_include @faultless_bike1
    end

    it "should dock bikes to a specified dockable" do
      @van.dock(@faultless_bike1)
      @van.drop_off(@docking_station1,@faultless_bike1)
      @docking_station1.bikes.must_include @faultless_bike1
    end
  end


  describe "redistribute" do

    before do
      @docking_station1.dock(@faultless_bike1)
      @docking_station1.dock(@faultless_bike2)
      @docking_station1.dock(@faultless_bike3)
      @docking_station2.dock(@faultless_bike4)
      @garage1.dock(@duff_bike1)
    end

    it "should respond to redistribute" do
      @van.must_respond_to :redistribute
    end

    describe "how_hungry_for" do
      it "should return a numeric score for how hungry the dockable is for a given bike type based on calculation: hunger level * no. of empty spaces" do
        skip
        ################ DEBUGGING ##########
        puts "@garage1's how_hungry_for Bikes::BROKEN is: #{@van.how_hungry_for(@garage1, Bike::BROKEN)}"
        puts "@docking_station1's how_hungry_for Bikes::WORKING is: #{@van.how_hungry_for(@docking_station1, Bike::WORKING)}"
        ################################

        @docking_station1.set_hunger_for(Bike::WORKING => 2)
        @van.how_hungry_for(@docking_station1, Bike::WORKING).must_equal @docking_station1.get_hunger_for(Bike::WORKING) * (@docking_station1.capacity - @docking_station1.bikes_count)
      end
    end

    describe "most_hungry_for" do
      it "should return the dockable that is most hungry for a given bike type" do
        skip
        @van.most_hungry_for(Bike::WORKING).must_equal @docking_station2
      end
    end

    describe "most_hungry" do
      
      it "should return hash" do
        skip
        @van.most_hungry.must_be_kind_of Hash
      end

      it "should return the most hungry dockable" do
        skip
        return_hash = { :most_hungry_dockable => @garage1.object_id, :hungry_for => Bike::BROKEN, :number_desired => 9}
        @van.most_hungry.must_equal return_hash
      end

      it "should return the type hungry dockable" do
        skip
      end


    end



    describe "most_full_of" do
      it "should" do
        skip
      end
    end

    describe "how_full_of" do
      it "should" do
        skip
      end
    end
  end


end