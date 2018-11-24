class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :owner_id
      t.string :title
      t.text :content
      t.string :image
      t.timestamps null: false

    end
    add_index :events, :owner_id
  end
end
