class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|

      t.timestamps
      t.string :first_name
      t.string :last_name
      t.string :title
      t.integer :party_id
      t.integer :electorate_id
    end
  end
end
