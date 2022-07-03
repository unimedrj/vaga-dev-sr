class AddLanguageToRepositories < ActiveRecord::Migration[7.0]
  def change
    add_column :repositories, :language, :string, null: false
  end
end
