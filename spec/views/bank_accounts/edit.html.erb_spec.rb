require 'rails_helper'

RSpec.describe 'bank_accounts/edit' do
  let(:balance) { BankAccountBalance.new(balance: '462.23') }
  let(:bank_account) do
    BankAccount.create!(bank: 'FooBank', account: 'BarAccount', current_balance: balance)
  end

  before do
    assign(:bank_account, bank_account)
  end

  it 'displays the edit bank_account form' do
    render
    expect(rendered).to have_field('Bank', with: 'FooBank')
    expect(rendered).to have_field('Account', with: 'BarAccount')
    expect(rendered).to have_field('Balance', with: '462.23')
    expect(rendered).to have_button('Update Bank account')
    expect(rendered).to have_link('Back to bank accounts', href: bank_accounts_path)
  end

  it 'displays form validation errors' do
    bank_account.errors.add(:bank, "can't be blank")
    bank_account.errors.add(:account, "can't be blank")
    bank_account.errors.add(:balance, 'is not a number')
    assign(:bank_account, bank_account)
    render

    expect(rendered).to have_css('h2', text: '3 errors prohibited this bank account from being saved:')
    expect(rendered).to have_css('li', text: "Bank can't be blank")
    expect(rendered).to have_css('li', text: "Account can't be blank")
    expect(rendered).to have_css('li', text: 'Balance is not a number')
  end
end
