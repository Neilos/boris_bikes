require 'minitest/autorun'
require 'minitest/spec'
require '../lib/dockable'
require '../lib/bike'

class DockableClass
  include Dockable
end

describe Dockable do

  before do
    @dockable_instance = DockableClass.new
    @bike = Bike.new(1)
  end

  it "should have an id of integer" do
    @dockable_instance.id = 2
    @dockable_instance.id.must_be_kind_of(Integer)
  end

  it "should be able to count the number of bikes docked" do
    @dockable_instance.bikes_count.must_be_kind_of(Integer)
  end

  it "should return a zero bike count for a new instance" do
    @dockable_instance.bikes_count.must_equal 0
  end

  it "should be able to dock a bike" do
    @dockable_instance.dock(@bike)
  end

  it "should return a list of available bikes" do
    @dockable_instance.available_bikes.must_be_kind_of(Array)
    ###### NEEDS MORE WORK ###############
  end

end
