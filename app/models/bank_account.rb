class BankAccount < ApplicationRecord
  monetize :balance_cents

  validates :bank, presence: true, length: { minimum: 3, maximum: 50 }
  validates :account, presence: true, length: { minimum: 3, maximum: 50 }
  validates :balance, presence: true, numericality: true
end
