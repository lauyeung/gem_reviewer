class CreateRubyGems < ActiveRecord::Migration
  def change
    create_table :ruby_gems do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
