class CreateFileStorages < ActiveRecord::Migration[7.0]
  def change
    create_table :file_storages do |t|
      t.string :title
      t.text :description
      t.string :public_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
