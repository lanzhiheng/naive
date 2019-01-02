require 'rails_helper'

RSpec.describe ApplicationHelper, type: 'helper' do
  before(:all) do
    @page1 = Refinery::Page.create(
      title: 'home',
      show_in_menu: true,
      link_url: '/',
      slug: '/'
    )

    @page2 = Refinery::Page.create(
      title: 'blog',
      show_in_menu: true,
      slug: '/blog'
    )

    @page3 = Refinery::Page.create(
      title: 'about',
      show_in_menu: false,
      slug: '/about'
    )
  end

  after(:all) do
    Refinery::Page.all.each &:destroy!
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
end
