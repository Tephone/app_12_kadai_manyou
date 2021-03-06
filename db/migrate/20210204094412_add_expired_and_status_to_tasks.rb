class AddExpiredAndStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :expired_at, :datetime, default: -> { 'NOW()' }, null: false
    add_column :tasks, :status, :integer, default: 0, null: false
  end
end
