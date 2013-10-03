class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :ruby_gem_id, null: false
      t.integer :user_id, null: false
      t.string :title, null: false
      t.integer :rating, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
