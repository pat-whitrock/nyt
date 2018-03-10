class BatchStoryCreation
  include ActiveModel::Validations

  validates :nyt_stories, length: { minimum: 1 }

  def save!
    if valid?
      persist!
      true
    else
      raise(ActiveRecord::RecordInvalid, self)
    end
  end

  private

  def nyt_stories
    @nyt_stories ||= NytStoryCollection.new.all
  end

  def persist!
    ActiveRecord::Base.transaction do
      nyt_stories.each { |nyt_story| StoryCreation.new(nyt_story).save! }
    end
  end
end
