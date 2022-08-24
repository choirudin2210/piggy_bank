class Wallets::TransfersController < ApplicationController
  before_action :set_wallets_transfer, only: %i[ show edit update destroy ]

  # GET /wallets/transfers or /wallets/transfers.json
  def index
    @wallet = Wallet.find(params[:wallet_id])
    @wallets = Wallet.all - [@wallet]
    puts @wallet.balance
  end

  # GET /wallets/transfers/1 or /wallets/transfers/1.json
  def show
  end

  # GET /wallets/transfers/new
  def new
    @wallets_transfer = Wallets::Transfer.new
  end

  # GET /wallets/transfers/1/edit
  def edit
  end

  # POST /wallets/transfers or /wallets/transfers.json
  def create
    @wallet = Wallet.find(params[:wallet_id])
    to_wallet = Wallet.find(params[:to_wallet_id])

    respond_to do |format|
      if @wallet.withdraw(to_wallet, params[:amount].to_f)
        format.html { redirect_to wallet_transfers_path(@wallet), notice: "Transfer was successfully created." }
        format.json { render :show, status: :created, location: @wallets_transfer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wallets/transfers/1 or /wallets/transfers/1.json
  def update
    respond_to do |format|
      if @wallets_transfer.update(wallets_transfer_params)
        format.html { redirect_to wallets_transfer_url(@wallets_transfer), notice: "Transfer was successfully updated." }
        format.json { render :show, status: :ok, location: @wallets_transfer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wallets_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wallets/transfers/1 or /wallets/transfers/1.json
  def destroy
    @wallets_transfer.destroy

    respond_to do |format|
      format.html { redirect_to wallets_transfers_url, notice: "Transfer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallets_transfer
      @wallets_transfer = Wallets::Transfer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wallets_transfer_params
      params.fetch(:wallets_transfer, {})
    end
end
