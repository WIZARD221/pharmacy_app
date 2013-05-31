class DrugsStores < ActiveRecord::Migration
  def change
    create_table :drugs_stores, :id => false do |t|
      t.references :drug, :store
    end
    add_index :drugs_stores, [:drug_id, :store_id]
  end
end
