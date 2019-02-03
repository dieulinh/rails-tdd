class CommuneStreet < ActiveRecord::Base
  belongs_to :commune
  belongs_to :street
end
