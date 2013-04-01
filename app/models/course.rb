class Course < ActiveRecord::Base
  attr_accessible :category_id, :cost_per_day, :duration, :is_published, :short_title, :summary, :title, :objectives, :category
  validates :title, presence: true

  validates :duration, presence: true
  validates :duration, :numericality => {:only_integer => true}

  validates :cost_per_day, presence:true
  validates :cost_per_day, :numericality => {:only_float => true}

  has_many :objectives, :dependent => :destroy
  belongs_to :category
end
