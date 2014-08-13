class Scenario < ActiveRecord::Base
  extend FriendlyId

  belongs_to :page
  has_many :products

  validates_presence_of :name

  # Use :name field as slug for ID
  friendly_id :name, use: :slugged

  # Paperclip file configuration
  has_attached_file :avatar,
                    :styles => { :default => '175x175' },
                    :default_url => '/assets/images/defaults/avatar.png'

  # Paperclip validation helper method to ensure header image type is valid
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
