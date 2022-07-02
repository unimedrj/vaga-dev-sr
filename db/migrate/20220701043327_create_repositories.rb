class CreateRepositories < ActiveRecord::Migration[7.0]
  def change
    create_table :repositories do |t|
      t.string :name, null: false
      t.string :full_name, null: false
      t.string :description
      t.string :external_id, null: false, index: { unique: true }
      t.jsonb :metadata, null: false, default: {}

      t.timestamps null: false
    end
  end
end
