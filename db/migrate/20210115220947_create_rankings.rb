
class CreateRankings < ActiveRecord::Migration[6.0]
  def change
    create_table :rankings do |t|
      t.integer :value
      t.belongs_to :response, foreign_key: true
      t.belongs_to :choice, foreign_key: true

      t.timestamps
    end
  end
end
