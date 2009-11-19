class RolesUsuarios < ActiveRecord::Migration

  def self.up
    create_table "roles_usuarios", :id => false, :force => true do |t|
      t.integer  "usuario_id"
      t.integer  "role_id"

      t.timestamps
    end
  end

  def self.down
  end

end

