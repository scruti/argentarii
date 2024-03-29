class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: %i[show edit update destroy]

  # GET /bank_accounts or /bank_accounts.json
  def index
    @bank_accounts = BankAccount.all
  end

  # GET /bank_accounts/1 or /bank_accounts/1.json
  def show; end

  # GET /bank_accounts/new
  def new
    @bank_account = BankAccount.new
    @bank_account.build_current_balance
  end

  # GET /bank_accounts/1/edit
  def edit; end

  # POST /bank_accounts or /bank_accounts.json
  def create
    @bank_account = BankAccount.new(bank_account_params)

    respond_to do |format|
      if @bank_account.save
        format.html { redirect_to bank_account_url(@bank_account), notice: t('.notice') }
        format.json { render :show, status: :created, location: @bank_account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bank_accounts/1 or /bank_accounts/1.json
  def update
    respond_to do |format|
      if @bank_account.update(bank_account_params)
        format.html { redirect_to bank_account_url(@bank_account), notice: t('.notice') }
        format.json { render :show, status: :ok, location: @bank_account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_accounts/1 or /bank_accounts/1.json
  def destroy
    @bank_account.destroy

    respond_to do |format|
      format.html { redirect_to bank_accounts_url, notice: t('.notice') }
      format.json { head :no_content }
    end
  end

  private

  def set_bank_account
    @bank_account = BankAccount.find(params[:id])
  end

  def bank_account_params
    params.require(:bank_account).permit(:bank, :account, current_balance_attributes: [:id, :balance])
  end
end
