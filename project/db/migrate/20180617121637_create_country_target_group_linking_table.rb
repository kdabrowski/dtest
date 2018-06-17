class CreateCountryTargetGroupLinkingTable < ActiveRecord::Migration[5.2]
  def change
    create_table :countries_target_groups do |t|
      t.references :country, foreign_key: true, index: true
      t.references :target_group, foreing_key: true, index: true
    end
  end
end
