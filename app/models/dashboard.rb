class Dashboard
  MARTIAN_REGEX = /\Amartian\z/i.freeze

  def initialize(current_language = nil)
    @current_language = current_language
  end

  def featured_stories
    @featured_stories ||= with_caching('featured') { Story.with_image.recent }
  end

  def side_stories
    @side_stories ||= with_caching('side') { Story.without_image.recent }
  end

  def toggle_language
    english? ? 'Martian' : 'English'
  end

  def toggle_language_label
    "#{toggle_language} #{toggle_language_emoji}"
  end

  private

  def current_language
    if MARTIAN_REGEX.match? @current_language
      'Martian'
    else
      'English'
    end
  end

  def english?
    current_language == 'English'
  end

  def martianize(story)
    english? ? story : MartianPresenter.new(story)
  end

  def toggle_language_emoji
    english? ? '👾' : '📚'
  end

  def with_caching(story_type)
    Rails.cache.fetch("#{Story.unscoped.joins(:images).cache_key}/#{story_type}/#{current_language}") do
      yield.map(&method(:martianize))
    end
  end
end
