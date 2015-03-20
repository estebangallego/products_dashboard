class Product < ActiveRecord::Base
	# has_secure_password
	validates :name, :description, :pricing, presence: true
	belongs_to :category
end
