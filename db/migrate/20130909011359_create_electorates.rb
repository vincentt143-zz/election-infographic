class CreateElectorates < ActiveRecord::Migration
  def change
    create_table :electorates do |t|

      t.timestamps
      t.string :name
      t.integer :labor_votes
      t.float :labor_percentage
      t.integer :liberal_votes
      t.float :liberal_percentage
    end
  end
end
