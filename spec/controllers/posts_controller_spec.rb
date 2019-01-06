require "rails_helper"

module Refinery
  module Blog
    describe PostsController, :type => :controller do
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

      it "tagged action" do
        # TODO: Can not pass, need to be fixed.
        get 'tagged_by_name', params: { tag_name: @rails.name }
        expect(assigns(:posts).size).to eq(0)
        expect(assigns(:tag)).to eq(@rails)

        get :tagged_by_name, params: { tag_name: @language.name }
        expect(assigns(:posts).size).to eq(1)
        expect(assigns(:tag).size).to eq(@language)
        expect(assigns(:posts)).to include(@docker)
      end
    end
  end
end
