class Commune < ActiveRecord::Base
  has_many :commune_streets, dependent: :destroy
  has_many :streets, through: :commune_streets
  belongs_to :intercommunality, optional: true

  validates :name, :code_insee, presence: true, length: { minimum: 4 }

  scope :search, -> (keyword) { where("lower(name) LIKE :keyword", keyword: "%#{sanitize_sql_like(keyword.downcase)}%") }
  def self.to_hash
    {}.tap do |commune_hash|
      all.each { |commune| commune_hash[commune.code_insee] = commune.name }
    end
  end
end
