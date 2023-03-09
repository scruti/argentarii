require 'rails_helper'

RSpec.describe BankAccount do
  describe 'validations' do
    let(:bank_account) { described_class.new }

    it 'validates presence of bank' do
      expect(bank_account).not_to be_valid
      expect(bank_account.errors[:bank]).to include("can't be blank")
    end

    it 'validates minimum length of bank' do
      bank_account.bank = 'a'
      expect(bank_account).not_to be_valid
      expect(bank_account.errors[:bank]).to include('is too short (minimum is 3 characters)')
    end

    it 'validates maximum length of bank' do
      bank_account.bank = 'a' * 51
      expect(bank_account).not_to be_valid
      expect(bank_account.errors[:bank]).to include('is too long (maximum is 50 characters)')
    end

    it 'validates presence of account' do
      expect(bank_account).not_to be_valid
      expect(bank_account.errors[:account]).to include("can't be blank")
    end

    it 'validates minimum length of account' do
      bank_account.account = 'a'
      expect(bank_account).not_to be_valid
      expect(bank_account.errors[:account]).to include('is too short (minimum is 3 characters)')
    end

    it 'validates maximum length of account' do
      bank_account.account = 'a' * 51
      expect(bank_account).not_to be_valid
      expect(bank_account.errors[:account]).to include('is too long (maximum is 50 characters)')
    end
  end
end
