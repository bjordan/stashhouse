require 'spec_helper'

module StashHouse
  describe Wall do
    before :each do
      @wall = Wall.new
    end

    describe "#new" do
      it "takes no parameters and returns a Wall object" do
        @wall.should be_an_instance_of Wall
      end
    end
  end
end