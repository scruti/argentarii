require 'rails_helper'

RSpec.describe 'bank_accounts/index' do
  let(:first_account) { BankAccount.create!(bank: 'FirstBank', account: 'FirstAccount', balance: '24.32') }
  let(:second_account) { BankAccount.create!(bank: 'SecondBank', account: 'SecondAccount', balance: '134.00') }

  before do
    assign(:bank_accounts, [first_account, second_account])
  end

  it 'displays a list of bank_accounts' do
    render

    expect(rendered).to have_content('FirstBank')
    expect(rendered).to have_content('FirstAccount')
    expect(rendered).to have_content('£24.32')

    expect(rendered).to have_content('SecondBank')
    expect(rendered).to have_content('SecondAccount')
    expect(rendered).to have_content('£134.00')
  end

  it 'displays links to show and edit each bank account' do
    render

    expect(rendered).to have_link('Show this bank account', href: bank_account_path(first_account))
    expect(rendered).to have_link('Edit this bank account', href: edit_bank_account_path(first_account))

    expect(rendered).to have_link('Show this bank account', href: bank_account_path(second_account))
    expect(rendered).to have_link('Edit this bank account', href: edit_bank_account_path(second_account))
  end
end
