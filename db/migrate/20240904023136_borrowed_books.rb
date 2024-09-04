class BorrowedBooks < ActiveRecord::Migration[5.2]
    def change
        create_table :borrowed_books do |t|
          t.references :member, foreign_key: { to_table: :members, column: :member_id }
          t.references :book, foreign_key: { to_table: :books, column: :book_id }
          t.datetime :issue_date, default: -> { 'CURRENT_TIMESTAMP' }
          t.datetime :due_date
          t.boolean :is_returned, default: false

          t.timestamps
        end
    end
end
