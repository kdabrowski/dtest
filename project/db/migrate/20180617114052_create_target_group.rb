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

    add_foreign_key(:target_groups, :target_groups, column: :parent_id, primary_key: :id)
    add_index(:target_groups, :parent_id, unique: true)
  end
end
