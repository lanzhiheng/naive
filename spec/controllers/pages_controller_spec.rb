require "rails_helper"

describe 'Normal access', :type => :request do
  before(:all) do
    create(:home)
    create(:blog)
    create(:tech)
    create(:live)
  end

  after(:all) do
    Refinery::Page.all.each(&:destroy!)
    Refinery::Blog::Category.all.destroy_all
  end

  it "page with @categories by load_categories method" do
    get '/'
    expect(response.status).to eq(200)
    expect(assigns[:categories].length).to eq(2)
    expect(assigns[:categories].first.title).to eq(build(:tech).title)
    expect(assigns[:categories].last.title).to eq(build(:live).title)

    get '/blog'
    expect(response.status).to eq(200)
    expect(assigns[:categories].length).to eq(2)
    expect(assigns[:categories].first.title).to eq(build(:tech).title)
    expect(assigns[:categories].last.title).to eq(build(:live).title)

  end
end
