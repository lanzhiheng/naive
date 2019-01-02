class ApplicationHelperTest < ActionView::TestCase
  setup do
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

  test 'should render menu list' do
    assert_equal '<li class="nav-item mx-2"><a class="nav-link active" href="/">home</a></li><li class="nav-item mx-2"><a class="nav-link" href="/blog">blog</a></li>', menu_list('/')

    assert_equal '<li class="nav-item mx-2"><a class="nav-link" href="/">home</a></li><li class="nav-item mx-2"><a class="nav-link active" href="/blog">blog</a></li>', menu_list('/blog/post/1')
  end

  test 'link should return active' do
    assert_equal 'active', active_class('/', '/')
    assert_equal 'active', active_class('/blog', '/blog')
    assert_equal 'active', active_class('/blog/abc/abc', '/blog')
    assert_equal '', active_class('/', '/blog')
  end


  teardown do
    Refinery::Page.destroy_all
    Refinery::Page.last.destroy!
  end
end
