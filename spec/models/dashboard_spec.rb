require 'rails_helper'

RSpec.describe Dashboard do
  let!(:story_with_image1) do
    FactoryBot.create(
      :story,
      :with_images,
      image_count: 1,
      last_published: Time.parse('2012-01-01')
    )
  end
  let!(:story_with_image2) do
    FactoryBot.create(
      :story,
      :with_images,
      image_count: 2,
      last_published: Time.parse('2013-01-01')
    )
  end
  let!(:story_without_image1) do
    FactoryBot.create(:story, last_published: Time.parse('2013-01-01'))
  end
  let!(:story_without_image2) do
    FactoryBot.create(:story, last_published: Time.parse('2012-01-01'))
  end

  describe '#featured_stories' do
    it 'returns a collection of all stories with images' do
      expect(subject.featured_stories).to eq [story_with_image2, story_with_image1]
    end
  end

  describe '#side_stories' do
    it 'returns a collection of all stories with images' do
      expect(subject.side_stories).to eq [story_without_image1, story_without_image2]
    end
  end
end
