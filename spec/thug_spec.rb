require 'spec_helper'

module StashHouse
  describe Thug do
    describe "#new" do
      it "is private" do
        expect { 
          Thug.new
        }.to raise_error (NoMethodError)
      end
    end

    describe ".create" do
      it "returns a Thug" do
        Thug.create.should be_an_instance_of Thug
      end

      it "is an Actor" do
        Thug.create.is_a? Actor
      end

      it "has a name" do
        Thug.create.name.should_not be_empty
      end

      it "has a thug name" do
        names = %w[Chris Snoop Slim Marlow Stringer]
        names.index(Thug.create.name).should_not eql nil
      end
    end  
  end
end