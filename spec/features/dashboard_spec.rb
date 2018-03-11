require 'rails_helper'

RSpec.feature DashboardPage do
  before { BatchStoryCreation.new.save! }

  let(:martian_regex) { /boinga/i }

  scenario 'I can see featured and side stories in both Engligh and Martian' do
    subject.load

    expect(page).to have_current_path '/'

    expect(subject.featured_stories).to have_stories count: 13

    subject.featured_stories.stories.each do |story|
      expect(story.headline).to have_content
      expect(story.headline.text).not_to match martian_regex
      expect(story.last_published).to have_content
      expect(story.image).to have_content
      expect(story.summary).to have_content
      expect(story.summary.text).not_to match martian_regex
    end

    expect(subject.side_stories).to have_stories count: 6

    subject.featured_stories.stories.each do |story|
      expect(story.headline).to have_content
      expect(story.headline.text).not_to match martian_regex
      expect(story.last_published).to have_content
      expect(story.summary).to have_content
      expect(story.summary.text).not_to match martian_regex
    end

    subject.toggle_language_button.click

    expect(page).to have_current_path '/?language=Martian'

    expect(subject.featured_stories).to have_stories count: 13

    subject.featured_stories.stories.each do |story|
      expect(story.headline).to have_content
      expect(story.headline.text).to match martian_regex
      expect(story.last_published).to have_content
      expect(story.image).to have_content
      expect(story.summary).to have_content
      expect(story.summary.text).to match martian_regex
    end

    expect(subject.side_stories).to have_stories count: 6

    subject.featured_stories.stories.each do |story|
      expect(story.byline).to have_content
      expect(story.headline).to have_content
      expect(story.headline.text).to match martian_regex
      expect(story.last_published).to have_content
      expect(story.summary).to have_content
      expect(story.summary.text).to match martian_regex
    end

    subject.toggle_language_button.click

    expect(page).to have_current_path '/?language=English'

    expect(subject.featured_stories).to have_stories count: 13

    subject.featured_stories.stories.each do |story|
      expect(story.headline).to have_content
      expect(story.headline.text).not_to match martian_regex
      expect(story.last_published).to have_content
      expect(story.image).to have_content
      expect(story.summary).to have_content
      expect(story.summary.text).not_to match martian_regex
    end

    expect(subject.side_stories).to have_stories count: 6

    subject.featured_stories.stories.each do |story|
      expect(story.headline).to have_content
      expect(story.headline.text).not_to match martian_regex
      expect(story.last_published).to have_content
      expect(story.summary).to have_content
      expect(story.summary.text).not_to match martian_regex
    end
  end
end
