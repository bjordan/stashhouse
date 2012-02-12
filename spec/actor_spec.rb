require 'spec_helper'

module StashHouse
  describe Actor do
    before :all do
      @actorOne = Actor.new("Barry")
      @actorTwo = Actor.new("John")
      @actorThree = Actor.new("Barry")
    end

    describe "#new" do
      it "throws ArgumentError if no name passed" do
        expect { 
          Actor.new
        }.to raise_error(ArgumentError)
      end  
            
      it "takes name parameters and returns a Actor object" do
        @actorOne.should be_an_instance_of Actor
      end
    end

    describe "#eql?" do
      it "is not equal if names are different" do
        @actorOne.eql?(@actorTwo).should be_false
      end 

      it "is equal if names are the same" do
        @actorOne.eql?(@actorThree).should be_true
      end 
    end

    describe "name" do
      it "is a String" do
        @actorOne.name.should be_a String
      end

      it "returns correct name" do
        @actorOne.name.should eql "Barry"
      end
    end

    describe "location" do
      it "is an Array" do
        @actorOne.location.should be_an Array
      end

      it "is an Array of length 2" do
        @actorOne.location.size.should eql 2
      end  
    end
  end
end