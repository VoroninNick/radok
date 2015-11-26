class CreatePromoCodes < ActiveRecord::Migration
  def change
    create_table :promo_codes do |t|
      t.string :password
      t.float :percentage_discount

      t.timestamps null: false
    end
  end
end
