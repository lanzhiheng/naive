require "rails_helper"

module Refinery
  module Blog
    describe CategoriesController, :type => :controller do
      routes { Refinery::Core::Engine.routes }
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
        get :show, params: { id: @tech.slug }
        expect(assigns(:posts).size).to eq(2)

        get :show, params: { id: @live.slug }
        expect(assigns(:posts).size).to eq(0)
      end
    end
  end
end
