require 'rails_helper'

RSpec.describe 'bank_accounts/show' do
  let(:current_balance) { BankAccountBalance.new(balance: '3056.84') }
  let(:bank_account) { BankAccount.create!(bank: 'FooBank', account: 'BarAccount', current_balance:) }

  before do
    assign(:bank_account, bank_account)
  end

  it 'displays all the bank account attributes' do
    render
    expect(rendered).to have_content('FooBank')
    expect(rendered).to have_content('BarAccount')
    expect(rendered).to have_content('£3,056.84')
  end

  it 'displays buttons to edit, delete and go back to the bank accounts list' do
    render
    expect(rendered).to have_button('Delete this bank account')
    expect(rendered).to have_link('Edit this bank account', href: edit_bank_account_path(bank_account))
    expect(rendered).to have_link('Back to bank accounts', href: bank_accounts_path)
  end

  it 'displays the bank account balance history' do
    travel_to Time.zone.local(2023, 3, 10, 1, 4, 44) do
      bank_account.current_balance.save!
    end
    travel_to Time.zone.local(2023, 3, 9, 13, 3, 12) do
      bank_account.balances.create!(balance: '200.23')
    end
    travel_to Time.zone.local(2023, 3, 8, 12, 1, 3) do
      bank_account.balances.create!(balance: '3500.45')
    end

    render

    expect(rendered).to have_content('Balance history')
    expect(rendered).to have_content('2023-03-10 01:04:44 - £3,056.84')
    expect(rendered).to have_content('2023-03-09 13:03:12 - £200.23')
    expect(rendered).to have_content('2023-03-08 12:01:03 - £3,500.45')
  end
end
