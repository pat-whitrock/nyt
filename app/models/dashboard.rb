class Dashboard
  def featured_stories
    @featured_stories ||= Story.with_image.recent
  end

  def side_stories
    @side_stories ||= Story.without_image.recent
  end
end
