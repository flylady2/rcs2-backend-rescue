class CreateRankings < ActiveRecord::Migration[6.0]
  def change
    create_table :rankings do |t|
      t.integer :value
      t.belongs_to :response, null: false, foreign_key: true
      t.belongs_to :choice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
