class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
       t.text :title
      t.text :content
     

      t.timestamps null: false
    end
  end
end
