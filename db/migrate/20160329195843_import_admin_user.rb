class ImportAdminUser < ActiveRecord::Migration
  def up
    user = User.new(
      email: 'radok@admin.com',
      username: 'radok',
      password: 'radok123',
      password_confirmation: 'radok123',
      role: 'admin'
    )

    user.confirm!
    user.save!
  end

  def down
    User.find_by(email: 'radok@admin.com').destroy
  end
end
