class Story < ApplicationRecord
  self.inheritance_column = nil

  has_many :images

  scope :recent, -> { order(last_published: :desc) }
  scope :with_image, -> { includes(:images).where.not(images: { id: nil }) }
  scope :without_image, -> { includes(:images).where(images: { id: nil }) }

  validates :headline, :last_published, :summary, :url, presence: true

  delegate :image_url, to: :preferred_image

  private

  def preferred_image
    images.find_by!(type: 'square320')
  end
end
