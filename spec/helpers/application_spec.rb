require 'rails_helper'

RSpec.describe ApplicationHelper, type: 'helper' do
  before(:all) do
    create(:home)
    create(:blog)
    create(:about)
  end

  after(:all) do
    Refinery::Page.all.each(&:destroy!)
  end

  it 'should render menu list' do
    expect(menu_list('/')).to eq('<li class="nav-item mx-2"><a class="nav-link active" href="/">home</a></li><li class="nav-item mx-2"><a class="nav-link" href="/blog">blog</a></li>')
    expect(menu_list('/blog/hello/world')).to eq('<li class="nav-item mx-2"><a class="nav-link" href="/">home</a></li><li class="nav-item mx-2"><a class="nav-link active" href="/blog">blog</a></li>')
  end

  it 'link should return active' do
    expect(active_class('/', '/')).to eq('active')
    expect(active_class('/blog', '/blog')).to eq('active')
    expect(active_class('/blog/abc/1', '/blog')).to eq('active')
    expect(active_class('/', '/blog')).to eq('')
  end

  it 'fontawesome and github markdown helper' do
    expect(foreign_link_resource).to include('fontawesome')
    expect(foreign_link_resource).to include('integrity')
    expect(foreign_link_resource).to include('crossorigin')
    expect(foreign_link_resource).to include('github-markdown')
  end
end
