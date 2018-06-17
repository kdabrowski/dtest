class CreateLocationGroup < ActiveRecord::Migration[5.2]
  def change
    create_table :location_groups do |t|
      t.references :country, foreign_key: true, index: true
      t.references :panel_provider, foreign_key: true, index: true
      t.string :name
    end
  end
end
