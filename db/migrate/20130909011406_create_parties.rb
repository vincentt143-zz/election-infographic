class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|

      t.timestamps
      t.string :name
      t.string :members
    end
  end
end
