require 'site_prism'

class DashboardPage < SitePrism::Page
  set_url '/'

  section :featured_stories, '.featured_stories' do
    sections :stories, 'article' do
      element :headline, '.headline a'
      element :byline, '.byline'
      element :last_published, '.last_published'
      element :image, '.image img'
      element :summary, '.summary'
    end
  end

  section :side_stories, '.side_stories' do
    sections :stories, 'article' do
      element :headline, '.headline a'
      element :byline, '.byline'
      element :last_published, '.last_published'
      element :summary, '.summary'
    end
  end
end
