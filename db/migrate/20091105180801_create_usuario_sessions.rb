class CreateUsuarioSessions < ActiveRecord::Migration
  def self.up
    create_table :usuario_sessions do |t|
      t.string :login
      t.string :password

      t.timestamps
    end
  end

  def self.down
    drop_table :usuario_sessions
  end
end
