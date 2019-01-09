require "rails_helper"

module Refinery
  module Blog
    describe PostsController, :type => :controller do
      # We need to specify the routes engine
      routes { Refinery::Core::Engine.routes }
      before(:all) do
        @container = build(:container)
        @rails = build(:rails)
        @language = build(:language)

        @docker = create(:docker, draft: false)
        @ruby = create(:ruby, draft: true)
        @docker.tags << [@container, @language]
        @ruby.tags << [@rails, @language]
      end

      after(:all) do
        Refinery::Blog::Post.destroy_all
        ActsAsTaggableOn::Tag.destroy_all
      end

      it "@posts in tagged page" do
        get :tagged_by_name, { params: { tag_name: @rails.name } }
        expect(assigns(:posts).size).to eq(0)
        expect(assigns(:tag)).to eq(@rails)

        get :tagged_by_name, { params: { tag_name: @language.name } }
        expect(assigns(:posts).size).to eq(1)
        expect(assigns(:tag)).to eq(@language)
        expect(assigns(:posts)).to include(@docker)
      end
    end
  end
end
