class AddWaveBAndCornerBToSubstrates < ActiveRecord::Migration[5.2]
  def change
    add_column :substrates, :wave_b, :string
    add_column :substrates, :corner_b, :string
  end
end
