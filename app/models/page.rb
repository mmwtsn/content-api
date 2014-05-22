class Page < ActiveRecord::Base
  # Paperclip file configuration
  has_attached_file :header, 
                    :styles => { :default => '1900x500' },
                    :default_url => '/images/default-header.png'

  # Paperclip validation helper method to ensure header image type is valid
  validates_attachment_content_type :header, :content_type => /\Aimage\/.*\Z/

  # Require all fields if the user attempts to publish the page
  with_options if: :published? do |published_page|
    published_page.validates :header, presence: true
    published_page.validates :title,  presence: true
    published_page.validates :body,   presence: true
  end
end
