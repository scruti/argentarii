require 'rails_helper'

RSpec.describe '/bank_accounts' do
  let(:valid_attributes) do
    { bank: 'BankName', account: 'AccountName', current_balance_attributes: { balance: '300.43' } }
  end

  let(:invalid_attributes) do
    { bank: '', account: '', current_balance_attributes: { balance: '300.43' } }
  end

  describe 'GET /index' do
    it 'renders a the list of bank accounts' do
      BankAccount.create! valid_attributes
      get bank_accounts_url
      expect(response).to be_successful
      expect(response.body)
        .to include('Bank accounts').and include('BankName').and include('AccountName').and include('£300.43')
    end
  end

  describe 'GET /show' do
    it 'renders the bank account details' do
      bank_account = BankAccount.create! valid_attributes
      get bank_account_url(bank_account)
      expect(response).to be_successful
      expect(response.body)
        .to include('BankName').and include('AccountName').and include('£300.43')
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_bank_account_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      bank_account = BankAccount.create! valid_attributes
      get edit_bank_account_url(bank_account)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new BankAccount' do
        expect do
          post bank_accounts_url, params: { bank_account: valid_attributes }
        end.to change(BankAccount, :count).by(1)
      end

      it 'redirects to the created bank_account' do
        post bank_accounts_url, params: { bank_account: valid_attributes }
        expect(response).to redirect_to(bank_account_url(BankAccount.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new BankAccount' do
        expect do
          post bank_accounts_url, params: { bank_account: invalid_attributes }
        end.not_to change(BankAccount, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post bank_accounts_url, params: { bank_account: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    let(:bank_account) { BankAccount.create! valid_attributes }

    context 'with valid parameters' do
      let(:new_attributes) do
        { bank: 'NewBankName',
          account: 'NewAccountName',
          current_balance_attributes: { id: bank_account.current_balance.id, balance: '10240.00' } }
      end

      it 'updates the requested bank_account' do
        patch bank_account_url(bank_account), params: { bank_account: new_attributes }
        expect(bank_account.reload).to have_attributes(bank: 'NewBankName', account: 'NewAccountName')
        expect(bank_account.current_balance).to have_attributes(balance_cents: 1_024_000)
      end

      it 'keeps the previous balance in the account balance history' do
        patch bank_account_url(bank_account), params: { bank_account: new_attributes }
        expect(bank_account.reload.balances.count).to eq(2)
        expect(bank_account.balances.first).to have_attributes(balance_cents: 30_043)
      end

      it 'redirects to the bank_account' do
        patch bank_account_url(bank_account), params: { bank_account: new_attributes }
        bank_account.reload
        expect(response).to redirect_to(bank_account_url(bank_account))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch bank_account_url(bank_account), params: { bank_account: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested bank_account' do
      bank_account = BankAccount.create! valid_attributes
      expect do
        delete bank_account_url(bank_account)
      end.to change(BankAccount, :count).by(-1)
    end

    it 'redirects to the bank_accounts list' do
      bank_account = BankAccount.create! valid_attributes
      delete bank_account_url(bank_account)
      expect(response).to redirect_to(bank_accounts_url)
    end
  end
end
