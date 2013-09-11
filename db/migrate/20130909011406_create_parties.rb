class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|

      t.timestamps
      t.string :name
      t.integer :member_id
    end
  end
end
