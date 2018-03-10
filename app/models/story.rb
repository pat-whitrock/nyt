class Story < ApplicationRecord
  self.inheritance_column = nil

  has_many :images

  validates :headline, :last_published, :summary, :url, presence: true
end
