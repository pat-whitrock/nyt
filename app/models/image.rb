class Image < ApplicationRecord
  self.inheritance_column = nil

  belongs_to :story

  validates :content, :type, presence: true, uniqueness: { scope: :story }
end
