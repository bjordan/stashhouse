require 'spec_helper'

module StashHouse
  describe ScoreBoard do
    before :each do
      @scoreboard = {'Barry' => 6, 'John' => 8}
      # stub file access methods for all instances of ScoreBoard
      # any_instance.stub doesn't work in before :all
      ScoreBoard.any_instance.stub(:load_from_file).and_return(@scoreboard)
      ScoreBoard.any_instance.stub(:write_to_file).and_return()
    end

    # helper method
    def create_and_update(name)
      p = Playa.new(name)
      p.moves = 5
      s = ScoreBoard.new
      s.update(p)      
    end

    describe "#update" do
      context "player not already on scoreboard" do
        it "adds player and score" do
          create_and_update("Henry")
          @scoreboard["Henry"].should eql 5
        end

        it "now has one more entry" do
          create_and_update("Henry")
          @scoreboard.length.should eql 3
        end
      end

      context "player already on scoreboard" do
        it "updates existing score" do
          create_and_update("Barry")
          @scoreboard["Barry"].should eql 5
        end

        it "scoreboard has same number of entries" do
          create_and_update("Barry")
          @scoreboard.length.should eql 2
        end
      end
    end
  end
end