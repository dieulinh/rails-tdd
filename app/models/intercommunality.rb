class Intercommunality < ActiveRecord::Base
  has_many :communes, dependent: :destroy
  validates :name, presence: true
  validates :siren, uniqueness: { case_sensitive: false }
  validates :siren, presence: true, length: { maximum: 10 }
  validates :form, inclusion: { in: %w(ca cu cc met) }
end
