require 'spec_helper'

module StashHouse
  describe Door do
    describe "#new" do
      it "takes no arguments and returns Door object" do
        Door.new.should be_an_instance_of Door
      end

      it "is locked by default" do
        d = Door.new
        d.locked.should be_false
      end
    end
  end
end