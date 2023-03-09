require 'rails_helper'

RSpec.describe 'bank_accounts/new' do
  let(:bank_account) { BankAccount.new(current_balance: BankAccountBalance.new) }

  it 'displays a new bank account form' do
    assign(:bank_account, bank_account)
    render

    expect(rendered).to have_css('h1', text: 'New Bank Account')
    expect(rendered).to have_field('Bank')
    expect(rendered).to have_field('Account')
    expect(rendered).to have_field('Balance', with: '0.00')
    expect(rendered).to have_button('Create Bank account')
    expect(rendered).to have_link('Back to bank accounts', href: bank_accounts_path)
  end

  it 'displays form validation errors' do
    bank_account.errors.add(:bank, "can't be blank")
    bank_account.errors.add(:account, "can't be blank")
    assign(:bank_account, bank_account)
    render

    expect(rendered).to have_css('h2', text: '2 errors prohibited this bank account from being saved:')
    expect(rendered).to have_css('li', text: "Bank can't be blank")
    expect(rendered).to have_css('li', text: "Account can't be blank")
  end
end
