class CreateSubMemberships < ActiveRecord::Migration
  def change
    create_table :sub_memberships do |t|
      t.integer :sub_id
      t.integer :user_id

      t.timestamps
    end
  end
end
