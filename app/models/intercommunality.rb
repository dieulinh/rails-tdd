class Intercommunality < ActiveRecord::Base
  has_many :communes, dependent: :destroy
  validates :name, presence: true
  validates :siren, uniqueness: { case_sensitive: false }
  validates :siren, presence: true, length: { maximum: 10 }
  validates :form, inclusion: { in: %w(ca cu cc met) }

  before_create :generate_slug

  before_update do
    unless self.slug
      generate_slug
    end
  end

  def communes_hash
    {}.tap do |commune_hash|
      communes.each { |commune| commune_hash[commune.code_insee] = commune.name }
    end
  end

  def population
    communes.pluck(:population).reduce(0, :+)
  end

  private

  def generate_slug
    return unless self.name
    tmp_slug = self.name.gsub(/é/,'e').downcase.gsub('metropole','').split(' ')
    tmp_slug.push('metropole') unless tmp_slug.include?('metropole')
    self.slug = tmp_slug.join('-')
  end
end
