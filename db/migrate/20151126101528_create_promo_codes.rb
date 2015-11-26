class CreatePromoCodes < ActiveRecord::Migration
  def change
    create_table :wizard_promo_codes do |t|
      t.string :password, null: false
      t.float :percentage_discount

      t.timestamps null: false
    end

    add_index :wizard_promo_codes, :password, unique: true
  end
end
