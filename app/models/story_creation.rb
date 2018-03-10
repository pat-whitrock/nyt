class StoryCreation
  include ActiveModel::Model

  attr_accessor :byline, :headline, :images, :last_published, :summary, :url

  alias_attribute :lastPublished, :last_published

  delegate :save!, to: :story

  private

  def formatted_images
    images.flat_map do |image|
      image[:types].map do |type|
        Image.new(type)
      end
    end
  end

  def story
    @story ||= Story.new(
      byline: byline,
      headline: headline,
      images: formatted_images,
      last_published: last_published,
      summary: summary,
      url: url
    )
  end
end
