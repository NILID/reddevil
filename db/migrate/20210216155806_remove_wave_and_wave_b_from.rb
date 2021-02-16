class RemoveWaveAndWaveBFrom < ActiveRecord::Migration[5.2]
  def change
    remove_column :substrates, :wave
    remove_column :substrates, :wave_b
  end
end
