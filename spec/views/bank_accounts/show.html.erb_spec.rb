require 'rails_helper'

RSpec.describe 'bank_accounts/show' do
  let(:bank_account) { BankAccount.create!(bank: 'FooBank', account: 'BarAccount', balance: '3056.84') }

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
end
