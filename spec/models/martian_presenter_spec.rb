require 'rails_helper'

RSpec.describe MartianPresenter do
  subject { described_class.new(presentable) }

  shared_examples_for 'a martianable string' do |method_name|
    let(:presentable) do
      double(method_name => "he's isn't shan't doesn't? Jo's Pat's Matt's Billy's Chris', so-so flip-flop.")
    end

    it 'replaces 4+ character words with "boinga", maintaining capitalization and punctuation' do
      expect(subject.public_send(method_name)).to eq "he's isn't boinga't boinga't? Jo's Pat's Boinga's Boinga's Boinga', so-so boinga-boinga."
    end
  end

  it_behaves_like 'a martianable string', :byline
  it_behaves_like 'a martianable string', :headline
  it_behaves_like 'a martianable string', :summary
end
