class AddRoleToUsers < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE user_roles AS ENUM ('admin', 'user');
      ALTER TABLE users ADD user_role user_roles;
    SQL
  end

  def down
    remove_column :users, :user_role
    execute <<-SQL
      DROP TYPE user_roles;
    SQL
  end
end
