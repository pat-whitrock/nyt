FactoryBot.define do
  factory :story do
    headline 'Headline 1'
    last_published Time.parse('2013-06-07T11:09:19.019.EDT')
    summary 'Summary 1'
    url 'Url 1'

    trait :with_images do
      transient { image_count 1 }

      images { build_list(:image, image_count, story: nil) }
    end
  end
end
