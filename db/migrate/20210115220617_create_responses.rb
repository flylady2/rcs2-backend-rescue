class CreateResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :responses do |t|
      t.string :token
      t.belongs_to :survey, foreign_key: true

      t.timestamps
    end
  end
end
