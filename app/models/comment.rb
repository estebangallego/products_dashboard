class Comment < ActiveRecord::Base
  belongs_to :product
  validates :comment, :product_id, presence: true
end

