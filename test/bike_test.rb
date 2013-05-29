require 'minitest/autorun'
require '../lib/bike'
require 'minitest/spec'

# class BikeTest < MiniTest::Test
#   def test_

#   end


describe Bike do 

  before do
    @bike = Bike.new
  end

  it "should not be broken when initialized" do
    @bike.broken?.wont_be true
  end
  
end