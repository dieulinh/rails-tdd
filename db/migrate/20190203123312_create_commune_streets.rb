class CreateCommuneStreets < ActiveRecord::Migration[5.0]
  def change
    create_table :commune_streets do |t|
      t.references :commune, index: true
      t.references :street, index: true
    end
  end
end
