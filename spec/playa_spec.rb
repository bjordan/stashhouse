require 'spec_helper'

module StashHouse
  describe Playa do
    before :all do
      @playa = Playa.new("Barry")
    end

    describe "#new" do
      it "takes name parameters and returns a Playa object" do
        @playa.should be_an_instance_of Playa
      end
    end

    it "is a Playa" do
      @playa.is_a? Actor
    end

    describe "name" do
      it "is a String" do
        @playa.name.should be_a String
      end

      it "returns correct name" do
        @playa.name.should eql "Barry"
      end
    end

    describe "location" do
      it "is an Array" do
        @playa.location.should be_an Array
      end

      it "is an Array of length 2" do
        @playa.location.size.should eql 2
      end  
    end

    describe "moves" do
      it "is an Integer" do
        @playa.moves.should be_a Integer
      end
    end
  end
end