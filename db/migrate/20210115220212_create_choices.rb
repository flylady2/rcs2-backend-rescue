class CreateChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :choices do |t|
      t.string :content
      t.boolean :winner
      t.belongs_to :survey, foreign_key: true

      t.timestamps
    end
  end
end
