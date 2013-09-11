class CreateElectorates < ActiveRecord::Migration
  def change
    create_table :electorates do |t|

      t.timestamps
      t.string :name
      t.integer :member_id
    end
  end
end
