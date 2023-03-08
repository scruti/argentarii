class BankAccountBalance < ApplicationRecord
  monetize :balance_cents

  belongs_to :bank_account

  validates :balance, presence: true, numericality: true
end
