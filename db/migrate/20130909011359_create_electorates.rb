class CreateElectorates < ActiveRecord::Migration
  def change
    create_table :electorates do |t|

      t.timestamps
      t.string :name
      t.string :parties
    end
  end
end
