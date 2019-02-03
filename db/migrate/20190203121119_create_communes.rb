class CreateCommunes < ActiveRecord::Migration[5.0]
  def change
    create_table :communes do |t|
      t.string :name
      t.string :code_insee
      t.references :intercommunality, index: true, foreign_key: true
    end
  end
end
