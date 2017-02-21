class AddReviewToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :review, :text
  end
end
