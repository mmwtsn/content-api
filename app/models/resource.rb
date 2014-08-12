class Resource < ActiveRecord::Base
  belongs_to :page

  validates_presence_of :body, :url
end
