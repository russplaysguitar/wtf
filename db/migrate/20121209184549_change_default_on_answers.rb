class ChangeDefaultOnAnswers < ActiveRecord::Migration
  def change
    change_column_default(:answers, :is_right, false)
  end
end
