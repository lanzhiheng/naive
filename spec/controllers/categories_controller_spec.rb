require "rails_helper"

module Refinery
  module Blog
    describe 'categories', :type => :request do
      before(:all) do
        @tech = create(:tech)
        @live = create(:live)

        @docker = create(:docker, draft: false)
        @docker.categories << @tech
        @ruby = create(:ruby, draft: false)
        @ruby.categories << @tech
      end

      after(:all) do
        Refinery::Blog::Post.destroy_all
        Refinery::Blog::Category.destroy_all
      end

      it "@posts in categories page" do
        get refinery.blog_category_path(@tech)
        expect(assigns(:posts).size).to eq(2)

        get refinery.blog_category_path(@live)
        expect(assigns(:posts).size).to eq(0)
      end
    end
  end
end
