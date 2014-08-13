class Page < ActiveRecord::Base
  extend FriendlyId

  has_many :scenarios, dependent: :destroy
  has_many :resources, dependent: :destroy

  validates_presence_of :name

  # Use :name field as slug for ID
  friendly_id :name, use: :slugged

  # Paperclip file configuration
  has_attached_file :header,
                    :styles => { :default => '1900x300' },
                    :default_url => '/assets/images/defaults/header.jpg'

  # Paperclip validation helper method to ensure header image type is valid
  validates_attachment_content_type :header, :content_type => /\Aimage\/.*\Z/

  # Require all fields if the user attempts to publish the page
  with_options if: :published? do |published_page|
    published_page.validates :header, presence: true
    published_page.validates :title,  presence: true
    published_page.validates :body,   presence: true
  end
end
