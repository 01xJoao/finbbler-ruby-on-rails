class Post < ActiveRecord::Base
    acts_as_votable
    
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :clothes, dependent: :destroy
    
    #cada upload é obrigado a ter uma imagem e um user
    validates :user_id, presence: true
    validates :image, presence: true
    validates :caption, length: { minimum: 2, maximum: 300 }
    
    scope :of_followed_users, -> (following_users) { where user_id: following_users }
    
    has_attached_file :image, styles: { :medium => "640x" }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end