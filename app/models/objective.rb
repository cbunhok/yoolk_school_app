class Objective < ActiveRecord::Base
  attr_accessible :course_id, :description, :title, :course
  belongs_to :course
  validates :title, presence: true
end
