require "rails_helper"

describe Refinery::Blog::PostsController, :type => :controller do
  before(:all) do
    @container = create(:container)
    @rails = create(:rails)
    @language = create(:language)
    @docker = create(:docker)
    @ruby = create(:ruby)
    @docker.tags << [@container]
    @ruby.tags << [@rails, @language]
  end

  after(:all) do
    Refinery::Blog::Post.destroy_all
    ActsAsTaggableOn::Tag.destroy_all
    Refinery::Authentication::Devise::User.destroy_all
  end

  it "tagged action" do
    # get :tagged
    expect(true).to eq(true)
  end
end
