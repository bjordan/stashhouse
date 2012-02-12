require 'spec_helper'

module StashHouse
  describe Room do
    describe "#new" do
      it "takes integer argument and returns Room object" do
        Room.new(1).should be_an_instance_of Room
      end
    end

    describe "walls" do
      it "has 4 walls" do
        Room.new(1).walls.length.should eql 4
      end

      it "has a Wall for each ordinal direction" do
        %w[N S E W].each { |direction| Room.new(1).walls[direction].should_not eql nil }
      end

      it "its walls are all of type Wall" do
        Room.new(1).walls.each { |direction, wall| wall.should be_an_instance_of Wall }
      end
    end
  end
end