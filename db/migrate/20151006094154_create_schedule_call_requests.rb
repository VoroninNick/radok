class CreateScheduleCallRequests < ActiveRecord::Migration
  def change
    create_table :schedule_call_requests do |t|
      t.string :phone
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
