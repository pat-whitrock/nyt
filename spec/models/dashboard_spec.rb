require 'rails_helper'

RSpec.describe Dashboard do
  subject { described_class.new(language) }

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
    context 'when current_language is "English"' do
      let(:language) { 'English' }

      it 'returns a collection of all stories with images ordered by recency' do
        expect(subject.featured_stories).to eq [story_with_image2, story_with_image1]
        expect(subject.featured_stories).to all be_a Story
      end
    end

    context 'when current_language is "Martian"' do
      let(:language) { 'Martian' }

      it 'returns a collection of all stories with images ordered by recency' do
        expect(subject.featured_stories).to eq [story_with_image2, story_with_image1]
        expect(subject.featured_stories).to all be_a MartianPresenter
      end
    end
  end

  describe '#side_stories' do
    context 'when current_language is "English"' do
      let(:language) { 'English' }

      it 'returns a collection of all stories without images ordered by recency' do
        expect(subject.side_stories).to all be_a Story
        expect(subject.side_stories).to eq [story_without_image1, story_without_image2]
      end
    end

    context 'when current_language is "Martian"' do
      let(:language) { 'Martian' }

      it 'returns a collection of all stories without images ordered by recency' do
        expect(subject.side_stories).to eq [story_without_image1, story_without_image2]
        expect(subject.side_stories).to all be_a MartianPresenter
      end
    end
  end

  describe '#toggle_language' do
    context 'when language is "English"' do
      let(:language) { 'English' }

      it 'returns "Martian"' do
        expect(subject.toggle_language).to eq 'Martian'
      end
    end

    context 'when language is "english"' do
      let(:language) { 'english' }

      it 'returns "Martian"' do
        expect(subject.toggle_language).to eq 'Martian'
      end
    end

    context 'when language is "Martian"' do
      let(:language) { 'Martian' }

      it 'returns "English"' do
        expect(subject.toggle_language).to eq 'English'
      end
    end

    context 'when language is "martian"' do
      let(:language) { 'martian' }

      it 'returns "English"' do
        expect(subject.toggle_language).to eq 'English'
      end
    end

    context 'when language is blank' do
      let(:language) { '' }

      it 'returns "Martian"' do
        expect(subject.toggle_language).to eq 'Martian'
      end
    end

    context 'when language is an unexpected value' do
      let(:language) { 'Spanish' }

      it 'returns "Martian"' do
        expect(subject.toggle_language).to eq 'Martian'
      end
    end
  end

  describe '#toggle_language_label' do
    context 'when language is "English"' do
      let(:language) { 'English' }

      it 'returns "Martian 👾"' do
        expect(subject.toggle_language_label).to eq 'Martian 👾'
      end
    end
  end

  context 'when language is "Martian"' do
    let(:language) { 'Martian' }

    it 'returns "English 📚"' do
      expect(subject.toggle_language_label).to eq 'English 📚'
    end
  end
end
