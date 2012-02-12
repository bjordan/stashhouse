require 'spec_helper'

module StashHouse
  describe House do
    before :each do
      @h = House.new(2,2)
    end

    describe "#new" do
      it "takes two int arguments and returns a House object" do
        @h.should be_an_instance_of House
      end

      it "creates array of length 'rows'" do
        @h.rooms.should have(2).items
      end

      it "creates array of length 'cols' for each row" do
        @h.rooms.each { |row| row.should have(2).items }
      end

      it "each row/col coordinate should be a room" do
        @h.rooms.each do |row|
          row.each do |room|
            room.should be_an_instance_of Room
          end
        end
      end
    end

    describe "#valid_room?" do
      it "has coordinates within house boundaries" do
        @h.valid_room?(0,1)
      end

      it "has coordinates outside house boundaries" do
        @h.valid_room?(0,3)
      end      
    end

    describe "#in_same_room?" do
      it "is true that the Playa and Stash are in the same room" do
        a = Playa.new("Barry")
        s = Stash.new(["a", "b"])
        @h.in_same_room?(a, s).should eql true
      end

      it "is false that the Playa and Stash are in the same room" do
        a = Playa.new("Barry")
        s = Stash.new(["a", "b"])
        s.location = [0,1]
        @h.in_same_room?(a, s).should eql false
      end      
    end

    describe "#move_actor" do
      it "is no longer in old room" do
        a = Actor.new("Barry")
        @h.rooms[0][0].contents.push(a)
        @h.move_actor(a, [0, 1])
        @h.rooms[0][0].contents.length.should eql 0
      end 
         
      it "has moved to room at new coordinates" do
        a = Actor.new("Barry")
        a.location = [0, 0]
        @h.rooms[0][0].contents.push(a)
        @h.move_actor(a, [0, 1])
        @h.rooms[0][1].contents[0].should be_an_instance_of Actor
      end    
    end 

    describe "#next_room_coords" do
      it "returns correct x,y coordinates for North" do
        @h.next_room_coords('N', [1,1]).should eql [0,1]
      end 
         
      it "returns correct x,y coordinates for South" do
        @h.next_room_coords('S', [1,1]).should eql [2,1]
      end  
 
      it "returns correct x,y coordinates for East" do
        @h.next_room_coords('E', [1,1]).should eql [1,2]
      end  
 
       it "returns correct x,y coordinates for West" do
        @h.next_room_coords('W', [1,1]).should eql [1,0]
      end  
    end 

    describe "#floor_plan" do
      it "returns non zero length string" do
        @h.floor_plan.should_not be_empty
      end 
    end
  end
end