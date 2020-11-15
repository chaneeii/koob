class RemoveFieldNameFromReview < ActiveRecord::Migration[6.0]
  def change
    remove_reference :reviews, :room, null: false, foreign_key: true
  end
end
