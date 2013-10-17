class CreateAgeStatistics < ActiveRecord::Migration
  def change
    create_table :age_statistics do |t|

      t.timestamps
      t.integer :ones
      t.integer :tens
      t.integer :twenties
      t.integer :thirties
      t.integer :forties
      t.integer :fifties
      t.integer :sixties
      t.integer :seventies_plus
      t.integer :electorate_id
    end
  end
end
