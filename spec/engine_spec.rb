require 'spec_helper'

module StashHouse
  describe Engine do
    before :each do
      Engine.any_instance.stub(:create_playa).and_return(Playa.new("Barry"))
      Engine.any_instance.stub(:load_config).and_return([5, 5, 3])
      Engine.any_instance.stub(:exit_program).and_return()
    end

    describe "#new" do
      it "takes no arguments and returns an Engine object" do
      end
    end
  end
end