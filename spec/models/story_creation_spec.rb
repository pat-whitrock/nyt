require 'rails_helper'

RSpec.describe StoryCreation do
  subject do
    described_class.new(
      byline: 'Byline 1',
      headline: 'Headline 1',
      images: images,
      lastPublished: Time.parse('2014-07-01T12:11:10.033.EDT'),
      summary: 'Summary 1',
      url: 'Url 1'
    )
  end
  let(:images) do
    [
      {
        types: [
          {
            content: 'Content 1',
            type: 'Type 1'
          },
          {
            content: 'Content 2',
            type: 'Type 2'
          }
        ]
      },
      {
        types: [
          {
            content: 'Content 3',
            type: 'Type 3'
          }
        ]
      }
    ]
  end

  describe '#save!' do
    it 'saves a story and any associated images' do
      expect {
        subject.save!
      }.to change {
        Story.count
      }.by(1).and change {
        Image.count
      }.by(3)

      expect(Image.all.map(&:story).uniq).to contain_exactly Story.first
    end
  end
end
