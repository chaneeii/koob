class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :status
      t.text :request_msg

      t.timestamps
    end
  end
end
