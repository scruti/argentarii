class BankAccountBalance < ApplicationRecord
  monetize :balance_cents

  belongs_to :bank_account

  validates :balance, presence: true, numericality: true

  before_update :create_instead_of_update

  def create_instead_of_update
    self.class.create!(bank_account:, balance_cents:) # creates a new record for the new balance
    self.balance_cents = balance_cents_was # keeps the original balance in the current record
  end
end
