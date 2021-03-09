class AddThresholdToSurveys < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :threshold, :integer
  end
end
