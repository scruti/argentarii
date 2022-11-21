class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def up
    create_table :bank_accounts do |t|
      t.string :bank
      t.string :account
      t.monetize :balance

      t.timestamps
    end

    change_column :bank_accounts, :balance_cents, :integer, limit: 8
  end

  def down
    drop_table :bank_accounts
  end
end
