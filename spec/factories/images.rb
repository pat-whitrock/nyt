FactoryBot.define do
  factory :image do
    story
    sequence(:content) { |i| "Content #{i}" }
    sequence(:type) { |i| "Type #{i}" }
  end
end
