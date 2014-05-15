class Page < ActiveRecord::Base
  has_attached_file :header, 
                    :styles => { :default => '1900x500' },
                    :default_url => 'http://openclipart.lynms.edu.hk/clipart/Clue/Clue_Simple_Clouds.svg'

  validates_attachment_content_type :header, :content_type => /\Aimage\/.*\Z/
end
