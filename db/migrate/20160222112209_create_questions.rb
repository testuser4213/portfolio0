class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :post_id
      t.integer :user_id
      t.string :title
      t.text :body

      t.timestamps null: false
    end
    add_index :questions, :post_id
    add_index :questions, :user_id
  end
end
