require 'rails_helper'

RSpec.describe Story do
  describe 'scopes' do
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
      FactoryBot.create(:story, last_published: Time.parse('2011-01-01'))
    end
    let!(:story_without_image2) do
      FactoryBot.create(:story, last_published: Time.parse('2014-01-01'))
    end

    describe '.recent' do
      it 'orders stories by last_published recency' do
        expect(described_class.recent).to eq [
          story_without_image2, story_with_image2, story_with_image1, story_without_image1
        ]
      end
    end

    describe '.with_image' do
      it 'returns a collection of all stories with images' do
        expect(described_class.with_image).to contain_exactly(story_with_image1, story_with_image2)
      end
    end

    describe '.without_image' do
      it 'returns a collection of all stories with images' do
        expect(described_class.without_image).to contain_exactly(story_without_image1, story_without_image2)
      end
    end
  end

  describe 'validations' do
    subject do
      described_class.new(
        byline: byline,
        headline: headline,
        last_published: last_published,
        summary: summary,
        url: url
      )
    end
    let(:byline) { 'Byline 1' }
    let(:headline) { 'Headline 1' }
    let(:last_published) { Time.parse('2013-06-07T11:09:19.019.EDT') }
    let(:summary) { 'Summary 1' }
    let(:url) { 'Url 1' }

    context 'when headline is absent' do
      let(:headline) { '' }

      it 'is invalid' do
        expect(subject).to be_invalid
        expect(subject.errors[:headline]).to contain_exactly("can't be blank")
      end
    end

    context 'when headline is present' do
      let(:headline) { 'Headline 1' }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when last_published is absent' do
      let(:last_published) { '' }

      it 'is invalid' do
        expect(subject).to be_invalid
        expect(subject.errors[:last_published]).to contain_exactly("can't be blank")
      end
    end

    context 'when last_published is present' do
      let(:last_published) { Time.parse('2013-06-07T11:09:19.019.EDT') }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when url is absent' do
      let(:url) { '' }

      it 'is invalid' do
        expect(subject).to be_invalid
        expect(subject.errors[:url]).to contain_exactly("can't be blank")
      end
    end

    context 'when url is present' do
      let(:url) { 'Url 1' }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end
  end

  describe '#image_url' do
    subject do
      described_class.create!(
        byline: 'Byline 1',
        headline: 'Headline 1',
        last_published: Time.parse('2013-06-07T11:09:19.019.EDT'),
        summary: 'Summary 1',
        url: 'Url 1'
      )
    end
    let!(:square320_image) do
      FactoryBot.create(:image, story: subject, content: 'path/to/pic.png', type: 'square320')
    end
    let!(:unassociated_square320_image) { FactoryBot.create(:image, type: 'square320') }
    let!(:non_square320_image) { FactoryBot.create(:image, story: subject, type: 'non_square320') }

    it "returns the image_url for this story's 'square320' image" do
      expect(subject.image_url).to eq 'https://graphics8.nytimes.com/path/to/pic.png'
    end
  end
end
