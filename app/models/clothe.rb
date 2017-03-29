class Clothe < ActiveRecord::Base
  belongs_to :post
    validates :clothe_name, presence: true
    validates :price, presence: true
    validates :store_name, presence: true
    validates :store_link, presence: true 
end
