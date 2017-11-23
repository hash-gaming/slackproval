class EmailBansController < ApplicationController
  before_action :set_email_ban, only: [:show, :edit, :update, :destroy]

  # GET /email_bans
  # GET /email_bans.json
  def index
    @email_bans = EmailBan.all
  end

  # GET /email_bans/1
  # GET /email_bans/1.json
  def show
  end

  # GET /email_bans/new
  def new
    @email_ban = EmailBan.new
  end

  # GET /email_bans/1/edit
  def edit
  end

  # POST /email_bans
  # POST /email_bans.json
  def create
    @email_ban = EmailBan.new(email_ban_params)

    respond_to do |format|
      if @email_ban.save
        format.html { redirect_to @email_ban, notice: 'Email ban was successfully created.' }
        format.json { render :show, status: :created, location: @email_ban }
      else
        format.html { render :new }
        format.json { render json: @email_ban.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /email_bans/1
  # PATCH/PUT /email_bans/1.json
  def update
    respond_to do |format|
      if @email_ban.update(email_ban_params)
        format.html { redirect_to @email_ban, notice: 'Email ban was successfully updated.' }
        format.json { render :show, status: :ok, location: @email_ban }
      else
        format.html { render :edit }
        format.json { render json: @email_ban.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_bans/1
  # DELETE /email_bans/1.json
  def destroy
    @email_ban.destroy
    respond_to do |format|
      format.html { redirect_to email_bans_url, notice: 'Email ban was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_ban
      @email_ban = EmailBan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_ban_params
      params.require(:email_ban).permit(:string)
    end
end
