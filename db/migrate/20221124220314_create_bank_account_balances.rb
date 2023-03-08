class CreateBankAccountBalances < ActiveRecord::Migration[7.0]
  def up
    create_table :bank_account_balances do |t|
      t.monetize :balance
      t.references :bank_account
      t.datetime :created_at, null: false
    end

    change_column :bank_account_balances, :balance_cents, :integer, limit: 8

    change_table :bank_accounts, bulk: true do |t|
      t.remove :balance_cents, :balance_currency
    end
  end

  def down
    drop_table :bank_account_balances

    change_table :bank_accounts do |t|
      t.monetize :balance
    end

    change_column :bank_accounts, :balance_cents, :integer, limit: 8
  end
end
