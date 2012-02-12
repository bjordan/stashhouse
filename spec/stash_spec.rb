require 'spec_helper'

module StashHouse
  describe Stash do
    before :all do
      @stashContents = ["10 red tops", "20 yellow tops"]
      @stash = Stash.new(@stashContents)
    end

    describe "#new" do
      it "throws ArgumentError if array argument not passed" do
        expect { 
          Stash.new
        }.to raise_error(ArgumentError)
      end    

      it "takes array parameter and returns a Stash object" do
        @stash.should be_an_instance_of Stash
      end
    end

    describe "contents" do
      it "is an Array" do
        @stash.contents.should be_an Array
      end

      it "is an Array of length 2" do
        @stash.location.size.should eql 2
      end  
   
       it "is the Array passed as argument to constructor" do
        @stash.contents.should =~ @stashContents
      end 
    end

    describe "location" do
      it "is an Array" do
        @stash.location.should be_an Array
      end

      it "is an Array of length 2" do
        @stash.location.size.should eql 2
      end  
    end
  end
end