class CreateEventNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :event_notifications do |t|

      t.timestamps
    end
  end
end
