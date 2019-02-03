class Commune < ActiveRecord::Base
  has_many :commune_streets, dependent: :destroy
  has_many :streets, through: :commune_streets
  belongs_to :intercommunality, optional: true
  validates :name, :code_insee, presence: true, length: { minimum: 4 }
end
