require "rails_helper"

describe 'Normal access', :type => :request do
  before(:all) do
    @home = create(:home)
    @blog = create(:blog)

    @tech = create(:tech)
    @live = create(:live)

    @ruby = create(:ruby, draft: false)
    @docker = create(:docker, draft: true)
  end

  after(:all) do
    Refinery::Page.all.each(&:destroy!)
    Refinery::Blog::Category.destroy_all
    Refinery::Blog::Post.destroy_all
  end

  it "page with @pages" do
    get '/'
    expect(response.status).to eq(200)
    expect(assigns[:pages].length).to eq(1)
    expect(assigns[:pages].first.title).to eq(@ruby.title)
  end

  it "page with @categories by load_categories method" do
    get '/'
    expect(response.status).to eq(200)
    expect(assigns[:categories].length).to eq(2)
    expect(assigns[:categories].first.title).to eq(@tech.title)
    expect(assigns[:categories].last.title).to eq(@live.title)

    get '/blog'
    expect(response.status).to eq(200)
    expect(assigns[:categories].length).to eq(2)
    expect(assigns[:categories].first.title).to eq(@tech.title)
    expect(assigns[:categories].last.title).to eq(@live.title)
  end
end
