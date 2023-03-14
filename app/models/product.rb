class Product < ApplicationRecord
  has_many :line_items
  has_many :reviews
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  validates :reviewer, presence: true
  validates :review, presence: true, length: { minimum: 10 }
  
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: { with: %r{\.(gif|jpg|png)\z}i, message: 'must be a URL for GIF, JPG or PNG image.' }

  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end

  private

  # ensure that there are no line items referencing this product
  
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
    throw :abort
    end
  end

end
