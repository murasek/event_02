class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.string :title
      t.text :content
      t.string :image
      t.timestamps null: false

    end
  end
end
