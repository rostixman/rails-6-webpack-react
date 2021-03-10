class CreateUserSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :user_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :gadget_uid
      t.string :gadget_token
      t.string :gadget_type
      t.string :auth_token
      t.boolean :is_notify, default: true

      t.timestamps
    end
  end
end
