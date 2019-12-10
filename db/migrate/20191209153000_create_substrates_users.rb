class CreateSubstratesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :substrates_users, id: false do |t|
      t.bigint :substrate_id, foreign_key: true, index: true
      t.integer :user_id, foreign_key: true, index: true
    end
  end
end
