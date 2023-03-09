class BankAccount < ApplicationRecord
  has_many :balances, class_name: 'BankAccountBalance', inverse_of: :bank_account, dependent: :destroy
  has_one :current_balance,
          -> { order(created_at: :desc) },
          class_name: 'BankAccountBalance',
          inverse_of: :bank_account,
          autosave: true,
          dependent: :destroy

  accepts_nested_attributes_for :current_balance

  delegate :balance, to: :current_balance

  validates :bank, presence: true
  validates :bank, length: { minimum: 3, maximum: 50 }, allow_blank: true
  validates :account, presence: true
  validates :account, length: { minimum: 3, maximum: 50 }, allow_blank: true
end
