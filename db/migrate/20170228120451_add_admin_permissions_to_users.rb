class AddAdminPermissionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :AdminPermissions, :boolean
  end
end
