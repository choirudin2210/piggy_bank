class TransfersController < ApplicationController
  before_action :set_transfer, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /transfers or /transfers.json
  def index
    @wallets = Wallet.all - [current_user.wallet]
  end

  # POST /transfers or /transfers.json
  def create
    @current_wallet = Current.user.wallet
    to_wallet = Wallet.find(params[:to_wallet_id])
    

    respond_to do |format|
      if @current_wallet.withdraw(to_wallet, params[:amount].to_f)
        format.html { redirect_to wallets_url, notice: "Transfer was successfully created." }
        format.json { render :index, status: :created, location: @transfer }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @current_wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transfer_params
      params.fetch(:transfer, {})
    end
end
