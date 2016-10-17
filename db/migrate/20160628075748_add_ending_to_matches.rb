class AddEndingToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :ending, :string, default: 'basic'
  end
end
