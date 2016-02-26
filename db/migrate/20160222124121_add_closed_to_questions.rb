class AddClosedToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :closed, :boolean
  end
end
