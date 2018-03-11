class Image < ApplicationRecord
  DOMAIN = 'https://graphics8.nytimes.com'.freeze

  self.inheritance_column = nil

  belongs_to :story

  validates :content, :type, presence: true, uniqueness: { scope: :story }

  def image_url
    URI::join(DOMAIN, content).to_s
  end
end
