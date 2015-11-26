class CreatePromoCodes < ActiveRecord::Migration
  def change
    create_table :wizard_promo_codes do |t|
      t.string :password
      t.float :percentage_discount

      t.timestamps null: false
    end
  end
end
