require 'rails_helper'

RSpec.describe NytStoryCollection do
  before do
    stub_request(:get, described_class::CONTENT_URI).to_return(
      body: File.new(Rails.root.join('spec', 'stubbed_responses', 'truncated_content.json'))
    )
  end

  describe '#all' do
    it 'returns an array of asset hashes only including whitelisted attributes for those of type "Article"' do
      expect(subject.all.length).to eq 2
      expect(subject.all.first.to_h).to eq(
        'byline' => 'Byline 1',
        'headline' => 'Headline 1',
        'lastPublished' => 'Last Published 1',
        'summary' => 'Summary 1',
        'url' => 'Url 1',
        'images' => []
      )
      expect(subject.all.second.to_h).to eq(
        'byline' => 'Byline 3',
        'images' => [
          {
            'types' => [
              {
                'content' => 'Content 3',
                'type' => 'Type 3',
              },
              {
                'content' => 'Content 4',
                'type' => 'Type 4',
              }
            ]
          }
        ]
      )
    end
  end
end
