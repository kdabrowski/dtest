class CreateTargetGroup < ActiveRecord::Migration[5.2]
  def change
    create_table :target_groups do |t|
      t.string :name
      t.string :external_id, index: true, null: false
      t.string :secret_code, null: false
      t.integer :parent_id
      t.references :panel_provider, foreign_key: true

      t.timestamps
    end
  end
end
