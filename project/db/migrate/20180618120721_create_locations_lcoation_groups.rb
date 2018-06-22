class CreateLocationsLcoationGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :location_groups_locations do |t|
      t.references :location, index: true
      t.references :location_group, index: true
    end
  end
end
