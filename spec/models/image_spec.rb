require 'rails_helper'

RSpec.describe Image do
  subject { described_class.new(content: content, story: story, type: type) }
  let(:content) { 'Content 1' }
  let(:story) { Story.new }
  let(:type) { 'Type 1' }

  describe 'validations' do
    context 'when content is absent' do
      let(:content) { '' }

      it 'is invalid' do
        expect(subject).to be_invalid
        expect(subject.errors[:content]).to contain_exactly("can't be blank")
      end
    end

    context 'when content is present' do
      let(:content) { 'Headline 1' }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when content is not unique to other images associated with this story' do
      let(:content) { 'Content 1' }
      let!(:existing_image) do
        FactoryBot.create(:image, content: 'Content 1', story: story, type: 'Type 2')
      end
      let(:story) { FactoryBot.build(:story) }

      it 'is invalid' do
        expect(subject).to be_invalid
        expect(subject.errors[:content]).to contain_exactly('has already been taken')
      end
    end

    context 'when content is unique to other images associated with this story' do
      let(:content) { 'Content 2' }
      let!(:existing_image) do
        FactoryBot.create(:image, content: 'Content 1', story: story, type: 'Type 2')
      end
      let(:story) { FactoryBot.build(:story) }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when story is absent' do
      let(:story) { nil }

      it 'is invalid' do
        expect(subject).to be_invalid
        expect(subject.errors[:story]).to contain_exactly('must exist')
      end
    end

    context 'when story is present' do
      let(:story) { Story.new }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when type is absent' do
      let(:type) { '' }

      it 'is invalid' do
        expect(subject).to be_invalid
        expect(subject.errors[:type]).to contain_exactly("can't be blank")
      end
    end

    context 'when type is present' do
      let(:type) { Time.parse('2013-06-07T11:09:19.019.EDT') }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when type is not unique to other images associated with this story' do
      let(:type) { 'Type 1' }
      let!(:existing_image) do
        FactoryBot.create(:image, type: 'Type 1', story: story, content: 'Content 2')
      end
      let(:story) { FactoryBot.build(:story) }

      it 'is invalid' do
        expect(subject).to be_invalid
        expect(subject.errors[:type]).to contain_exactly('has already been taken')
      end
    end

    context 'when type is unique to other images associated with this story' do
      let(:type) { 'Type 2' }
      let!(:existing_image) do
        FactoryBot.create(:image, type: 'Type 1', story: story, content: 'Content 2')
      end
      let(:story) { FactoryBot.build(:story) }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end
  end

  describe '#image_url' do
    let(:content) { 'path/to/an/image.jpg' }

    it "joins the image's content to IMAGE_DOMAIN" do
      expect(subject.image_url).to eq 'https://graphics8.nytimes.com/path/to/an/image.jpg'
    end
  end
end
