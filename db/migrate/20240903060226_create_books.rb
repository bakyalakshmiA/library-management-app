class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name, null: false , limit: 50
      t.string :email, null: false, index: { unique: true }
      t.bigint :phone_number
      t.boolean :active, default: true
      t.integer :member_id, index: true
      t.datetime :started_at
      t.datetime :ended_at
      t.timestamps
    end
  end
end