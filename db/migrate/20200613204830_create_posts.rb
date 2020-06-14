class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.references :category, foreign_key: true, index: true

      t.timestamps
    end
  end
end
