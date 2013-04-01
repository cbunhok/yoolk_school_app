class Category < ActiveRecord::Base
  attr_accessible :description, :title, :courses

  validates :title, presence: true
  has_many :courses, :dependent => :destroy
end
