class RemovePagesContentFromDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      UPDATE pages SET content = '' WHERE id=5
    SQL
  end
  def down
    execute(<<-SQL)
      UPDATE pages SET content = '' WHERE id=5
    SQL
  end
end
