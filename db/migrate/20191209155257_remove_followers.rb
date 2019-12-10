class RemoveFollowers < ActiveRecord::Migration[5.2]
  def change
    Follow.where(followable_type: 'Substrate').destroy_all
  end
end
