class CreateReligionStatistics < ActiveRecord::Migration
  def change
    create_table :religion_statistics do |t|

      t.timestamps
      t.integer :christianity
      t.integer :buddhism
      t.integer :judaism
      t.integer :islam
      t.integer :hinduism
      t.integer :no_religion
      t.integer :other
      t.integer :electorate_id
    end
  end
end
