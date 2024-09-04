class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title, null: false, limit: 50
      t.string :author, null: false, limit: 50
      t.string :language, null: false, limit: 50
      t.boolean :availability, default: true
      t.integer :book_id, null: false, index: { unique: true }

      t.timestamps
    end
  end
end