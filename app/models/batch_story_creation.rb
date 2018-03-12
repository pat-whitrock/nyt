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

  # Persist the entire batch as one atomic transaction
  # Trust the entire NYT payload is valid
  # If any individual story is invalid, roll back the entire batch
  def persist!
    ActiveRecord::Base.transaction do
      nyt_stories.each { |nyt_story| StoryCreation.new(nyt_story).save! }
    end
  end
end
