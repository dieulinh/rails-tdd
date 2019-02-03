class Street < ApplicationRecord
  has_many :commune_streets, dependent: :destroy
  has_many :communes, through: :commune_streets

  validates :title, presence: true
  validates_numericality_of :from, allow_nil: true
  validates_numericality_of :to, :greater_than => :from,  allow_nil: true
end
