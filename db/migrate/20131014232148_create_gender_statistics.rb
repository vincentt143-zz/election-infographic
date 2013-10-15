class CreateGenderStatistics < ActiveRecord::Migration
  def change
    create_table :gender_statistics do |t|

      t.timestamps
      t.integer :males
      t.integer :females
      t.integer :electorate_id
    end
  end
end
