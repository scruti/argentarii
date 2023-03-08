require 'rails_helper'

RSpec.describe BankAccountBalance do
  describe 'validations' do
    let(:bank_account_balance) { described_class.new }

    it 'validates presence of balance' do
      bank_account_balance.balance_cents = nil
      expect(bank_account_balance).not_to be_valid
      expect(bank_account_balance.errors[:balance]).to include("can't be blank")
    end

    it 'validates numericality of balance' do
      bank_account_balance.balance = 'abc'
      expect(bank_account_balance).not_to be_valid
      expect(bank_account_balance.errors[:balance]).to include('must be a number')
    end
  end
end
