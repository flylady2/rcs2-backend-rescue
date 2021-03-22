class CreateSurveys < ActiveRecord::Migration[6.0]
  def change
    create_table :surveys do |t|
      t.string :name
      t.string :user_email
      t.integer :threshold

      t.timestamps
    end
  end
end
