class ChangeTypeOfGadgetType < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE gadget_types AS ENUM ('ios', 'android', 'browser');
      ALTER TABLE user_sessions ALTER gadget_type TYPE gadget_types USING gadget_type::gadget_types;
    SQL
  end

  def down
    change_column :user_sessions, :gadget_type, :string
    execute <<-SQL
      DROP TYPE gadget_types;
    SQL
  end
end
