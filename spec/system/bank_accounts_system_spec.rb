require 'rails_helper'

RSpec.describe 'Bank Accounts' do
  it 'Creating a new bank account' do
    visit '/'

    expect(page).to have_css('h1', text: 'Bank accounts')

    click_link 'New bank account'

    expect(page).to have_current_path('/bank_accounts/new')
    expect(page).to have_css('h1', text: 'New Bank Account')

    fill_in 'Bank', with: 'FooBank'
    fill_in 'Account', with: 'BarAccount'
    fill_in 'Balance', with: '462.23'
    click_button 'Create Bank account'

    expect(page).to have_current_path("/bank_accounts/#{BankAccount.last.id}")
    expect(page).to have_text('Bank account was successfully created.')
    expect(page).to have_css('p', text: 'Bank: FooBank')
    expect(page).to have_css('p', text: 'Account: BarAccount')
    expect(page).to have_css('p', text: 'Balance: £462.23')

    click_link 'Back to bank accounts'

    expect(page).to have_current_path('/bank_accounts')
    expect(page).to have_css('h1', text: 'Bank accounts')
    expect(page).to have_css('p', text: 'Bank: FooBank')
    expect(page).to have_css('p', text: 'Account: BarAccount')
    expect(page).to have_css('p', text: 'Balance: £462.23')
  end

  it 'Editing a bank account' do
    balance = BankAccountBalance.new(balance: '462.23')

    travel_to Time.zone.local(2023, 3, 10, 1, 4, 44)
    bank_account = BankAccount.create!(bank: 'FooBank', account: 'BarAccount', current_balance: balance)
    travel_back

    travel_to Time.zone.local(2023, 3, 15, 13, 6, 21)
    visit '/'

    expect(page).to have_css('h1', text: 'Bank accounts')
    expect(page).to have_css('p', text: 'Bank: FooBank')
    expect(page).to have_css('p', text: 'Account: BarAccount')
    expect(page).to have_css('p', text: 'Balance: £462.23')

    click_link 'Edit this bank account'

    expect(page).to have_current_path("/bank_accounts/#{bank_account.id}/edit")
    expect(page).to have_css('h1', text: 'Editing bank account')
    expect(page).to have_field('Bank', with: 'FooBank')
    expect(page).to have_field('Account', with: 'BarAccount')
    expect(page).to have_field('Balance', with: '462.23')

    fill_in 'Bank', with: 'NewBank'
    fill_in 'Account', with: 'NewAccount'
    fill_in 'Balance', with: '2000'
    click_button 'Update Bank account'

    expect(page).to have_current_path("/bank_accounts/#{bank_account.id}")
    expect(page).to have_text('Bank account was successfully updated.')
    expect(page).to have_css('p', text: 'Bank: NewBank')
    expect(page).to have_css('p', text: 'Account: NewAccount')
    expect(page).to have_css('p', text: 'Balance: £2,000.00')
    expect(page).to have_css('li', text: '2023-03-10 01:04:44 - £462.23')
    expect(page).to have_css('li', text: '2023-03-15 13:06:21 - £2,000.00')

    click_link 'Back to bank accounts'

    expect(page).to have_current_path('/bank_accounts')
    expect(page).to have_css('h1', text: 'Bank accounts')
    expect(page).to have_css('p', text: 'Bank: NewBank')
    expect(page).to have_css('p', text: 'Account: NewAccount')
    expect(page).to have_css('p', text: 'Balance: £2,000.00')
    travel_back
  end

  it 'Deleting a bank account' do
    balance = BankAccountBalance.new(balance: '462.23')
    bank_account = BankAccount.create!(bank: 'FooBank', account: 'BarAccount', current_balance: balance)
    visit '/'

    expect(page).to have_css('h1', text: 'Bank accounts')
    expect(page).to have_css('p', text: 'Bank: FooBank')
    expect(page).to have_css('p', text: 'Account: BarAccount')
    expect(page).to have_css('p', text: 'Balance: £462.23')

    click_link 'Show this bank account'

    expect(page).to have_current_path("/bank_accounts/#{bank_account.id}")
    expect(page).to have_css('p', text: 'Bank: FooBank')
    expect(page).to have_css('p', text: 'Account: BarAccount')
    expect(page).to have_css('p', text: 'Balance: £462.23')
    click_button 'Delete this bank account'

    expect(page).to have_current_path('/bank_accounts')
    expect(page).to have_text('Bank account was successfully deleted.')
    expect(page).to have_css('h1', text: 'Bank accounts')
    expect(page).not_to have_css('p', text: 'Bank: FooBank')
    expect(page).not_to have_css('p', text: 'Account: BarAccount')
    expect(page).not_to have_css('p', text: 'Balance: £462.23')
  end
end
