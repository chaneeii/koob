class AddExtraFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :kakao, :string
    add_column :users, :s_description, :text
  end
end
