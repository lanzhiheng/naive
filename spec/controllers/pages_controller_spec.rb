require "rails_helper"

module Refinery
  describe PagesController, :type => :controller do
    routes { Refinery::Core::Engine.routes }

    before(:each) do
      @home = create(:home)
      @blog = create(:blog)
      @about = create(:about)

      @tech = create(:tech)
      @live = create(:live)

      @ruby = create(:ruby, draft: false)
      @docker = create(:docker, draft: true)
    end


    it "home page with @pages" do
      get :home
      expect(response.status).to eq(200)
      expect(assigns[:pages].length).to eq(1)
      expect(assigns[:pages].first.title).to eq(@ruby.title)
    end

    it "home page with @categories by load_categories method" do
      get :home
      expect(response.status).to eq(200)
      expect(assigns[:categories].length).to eq(2)
      expect(assigns[:categories].first.title).to eq(@tech.title)
      expect(assigns[:categories].last.title).to eq(@live.title)
    end
  end
end
