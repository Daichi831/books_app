class ChangeRelationshipsToFreindships < ActiveRecord::Migration[6.0]
  def change
    rename_table :relationships, :freindships
  end
end
