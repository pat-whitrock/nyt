require 'rails_helper'

RSpec.describe Story do
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
end
