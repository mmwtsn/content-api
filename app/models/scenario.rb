class Scenario < ActiveRecord::Base
  belongs_to :page
  has_many :products

  # Paperclip file configuration
  has_attached_file :avatar,
                    :styles => { :default => '175x175' },
                    :default_url => '/public/assets/images/defaults/avatar.png'

  # Paperclip validation helper method to ensure header image type is valid
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
