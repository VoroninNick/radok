class ImportAdminUser < ActiveRecord::Migration
  def up
    user = User.create(
      email: 'radok@admin.com',
      username: 'radok',
      password: 'radok123',
      password_confirmation: 'radok123',
      role: 'admin'
    )

    user.confirm!
  end

  def down
    User.find_by(email: 'radok@admin.com').destroy
  end
end
