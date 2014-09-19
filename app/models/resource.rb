class Resource < ActiveRecord::Base
  belongs_to :solution

  validates_presence_of :body, :url
end
