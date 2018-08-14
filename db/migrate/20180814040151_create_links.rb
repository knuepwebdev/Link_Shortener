class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :long_url
      t.string :short_url
      t.string :admin_url
      t.integer :usage_count, default: 0
      t.boolean :is_active, default: true
    end
  end
end
