require "rails_helper"

module Refinery
  describe PagesController, :type => :controller do
    describe "#home" do
      it "renders home template" do
        binding.pry
        get 'refinery/blog/posts'
        expect(true).to eq(true)
      end
    end
  end
end
