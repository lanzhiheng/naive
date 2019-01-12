require "rails_helper"
require 'redcarpet'

module Refinery
  module Blog
    describe PostsController, :type => :controller do
      # We need to specify the routes engine
      routes { Refinery::Core::Engine.routes }
      before(:each) do
        # tag
        @container = build(:container)
        @rails = build(:rails)
        @language = build(:language)

        # post
        @docker = create(:docker, draft: false)
        @ruby = create(:ruby, draft: true)

        @docker.tags << [@container, @language]
        @ruby.tags << [@rails, @language]
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

      it "@post in detail page" do
        markdown_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true)
        get :show, params: { id: @ruby.id }
        expect(assigns(:post).title).to eq(@ruby.title)
        expect(assigns(:post).body).to eq(@ruby.body)
        expect(assigns(:post).html_body).to eq(markdown_renderer.render(@ruby.body))
      end
    end
  end
end
