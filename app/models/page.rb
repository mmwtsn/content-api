class Page < ActiveRecord::Base
  has_attached_file :header, 
                    :styles => { :default => '1900x500' },
                    :default_url => '/images/default-header.png'

  validates_attachment_content_type :header, :content_type => /\Aimage\/.*\Z/
end
