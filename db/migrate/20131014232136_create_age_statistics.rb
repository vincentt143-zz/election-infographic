class CreateAgeStatistics < ActiveRecord::Migration
  def change
    create_table :age_statistics do |t|

      t.timestamps
      t.integer :under_twenty_five
      t.integer :twenty_five_to_thirty_nine
      t.integer :forties
      t.integer :fifties
      t.integer :sixty_and_over
      t.integer :electorate_id
    end
  end
end
