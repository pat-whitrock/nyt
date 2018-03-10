require 'rails_helper'

RSpec.describe BatchStoryCreation do
  describe '#save!' do
    context 'integration' do
      it 'persists all of the stories and images from the content endpoint' do
        expect {
          described_class.new.save!
        }.to change {
          Story.count
        }.by(19).and change {
          Image.count
        }.by(395)
      end
    end

    context 'unit' do
      before { allow(NytStoryCollection).to receive(:new).and_return(nyt_story_collection) }

      describe 'validations' do
        context 'when NytStoryCollection is empty' do
          let(:nyt_story_collection) { instance_double(NytStoryCollection, all: []) }

          it 'is invalid' do
            expect(subject).to be_invalid
            expect(subject.errors[:nyt_stories]).to contain_exactly('must contain at least 1 story')
          end
        end

        context 'when NytStoryCollection is not empty' do
          let(:nyt_story_collection) { instance_double(NytStoryCollection, all: [{}]) }

          it 'is valid' do
            expect(subject).to be_valid
          end
        end
      end

      describe '#save!' do
        context 'when valid' do
          let(:nyt_story_collection) do
            instance_double(NytStoryCollection, all: [nyt_story1, nyt_story2])
          end
          let(:nyt_story1) do
            {
              byline: 'byline',
              headline: 'headline',
              lastPublished: Time.parse('2013-06-07T11:09:19.019.EDT'),
              summary: 'summary',
              url: 'url',
              images: [
                {
                  types: [
                    {
                      content: 'Content 3',
                      type: 'Type 3'
                    }
                  ]
                }
              ]
            }
          end
          let(:nyt_story2) do
            {
              byline: 'byline',
              headline: 'headline',
              lastPublished: Time.parse('2014-07-01T12:11:10.033.EDT'),
              summary: 'summary',
              url: 'url',
              images: []
            }
          end

          it 'creates a story for each element of NytStoryCollection and returns true' do
            expect(subject.save!).to eq true
          end

          it 'creates a story for each element of NytStoryCollection' do
            expect {
              described_class.new.save!
            }.to change {
              Story.count
            }.by(2).and change {
              Image.count
            }.by(1)
          end

          context 'when some stories have been persisted and then an exception is raised' do
            before do
              allow(StoryCreation).to receive(:new).with(nyt_story1).and_return(story_creation1)
              allow(StoryCreation).to receive(:new).with(nyt_story2).and_return(story_creation2)
              allow(story_creation2).to receive(:save!).and_raise(StandardError)
            end

            let(:story_creation1) { instance_double(StoryCreation, save!: true) }
            let(:story_creation2) { instance_double(StoryCreation) }

            it 'rolls back the persistence of earlier stories' do
              expect {
                expect { described_class.new.save! }.to raise_error
              }.not_to change {
                Story.count
              }
            end

            it 'rolls back the persistence of earlier images' do
              expect {
                expect { described_class.new.save! }.to raise_error
              }.not_to change {
                Image.count
              }
            end
          end
        end

        context 'when invalid' do
          let(:nyt_story_collection) { instance_double(NytStoryCollection, all: []) }

          it 'raises ActiveRecord::Invalid' do
            expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end
      end
    end
  end
end
