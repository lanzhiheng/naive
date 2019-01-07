require "rails_helper"

module Refinery
  module Blog
    describe 'Tag', :type => :request do
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
        get refinery.blog_tagged_path(@rails.name)
        expect(assigns(:posts).size).to eq(0)
        expect(assigns(:tag)).to eq(@rails)

        get refinery.blog_tagged_path(@language.name)
        expect(assigns(:posts).size).to eq(1)
        expect(assigns(:tag)).to eq(@language)
        expect(assigns(:posts)).to include(@docker)
      end
    end
  end
end
