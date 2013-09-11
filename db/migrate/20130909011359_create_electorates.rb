class CreateElectorates < ActiveRecord::Migration
  def change
    create_table :electorates do |t|

      t.timestamps
      t.string :name
    end
  end
end
