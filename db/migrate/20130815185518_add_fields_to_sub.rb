class AddFieldsToSub < ActiveRecord::Migration
  def change
    add_column :subs, :moderator, :integer
  end
end
