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

  describe '#update' do
    let(:bank_account) { BankAccount.create!(bank: 'BankName', account: 'AccountName') }
    let(:bank_account_balance) { described_class.create!(balance_cents: 10_000, bank_account:) }

    it 'does not update the balance in the current record' do
      bank_account_balance.update(balance_cents: 20_000)
      expect(bank_account_balance.balance_cents).to eq(10_000)
    end

    it 'creates a new record for the new balance' do
      bank_account_balance
      expect { bank_account_balance.update(balance_cents: 20_000) }
        .to change(described_class, :count).by(1)
      expect(described_class.last.balance_cents).to eq(20_000)
    end
  end
end
