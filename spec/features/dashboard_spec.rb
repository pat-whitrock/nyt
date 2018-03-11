require 'rails_helper'

RSpec.feature DashboardPage do
  before { BatchStoryCreation.new.save! }

  scenario 'I can see featured and side stories' do
    subject.load
    expect(subject.featured_stories).to have_stories count: 13

    subject.featured_stories.stories.each do |story|
      expect(story.headline).to have_content
      expect(story.last_published).to have_content
      expect(story.image).to have_content
      expect(story.summary).to have_content
    end

    expect(subject.side_stories).to have_stories count: 6

    subject.featured_stories.stories.each do |story|
      expect(story.headline).to have_content
      expect(story.last_published).to have_content
      expect(story.summary).to have_content
    end
  end
end
