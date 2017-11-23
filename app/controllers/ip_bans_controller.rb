class IpBansController < ApplicationController
  before_action :set_ip_ban, only: [:show, :edit, :update, :destroy]

  # GET /ip_bans
  # GET /ip_bans.json
  def index
    @ip_bans = IpBan.all
  end

  # GET /ip_bans/1
  # GET /ip_bans/1.json
  def show
  end

  # GET /ip_bans/new
  def new
    @ip_ban = IpBan.new
  end

  # GET /ip_bans/1/edit
  def edit
  end

  # POST /ip_bans
  # POST /ip_bans.json
  def create
    @ip_ban = IpBan.new(ip_ban_params)

    respond_to do |format|
      if @ip_ban.save
        format.html { redirect_to @ip_ban, notice: 'Ip ban was successfully created.' }
        format.json { render :show, status: :created, location: @ip_ban }
      else
        format.html { render :new }
        format.json { render json: @ip_ban.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ip_bans/1
  # PATCH/PUT /ip_bans/1.json
  def update
    respond_to do |format|
      if @ip_ban.update(ip_ban_params)
        format.html { redirect_to @ip_ban, notice: 'Ip ban was successfully updated.' }
        format.json { render :show, status: :ok, location: @ip_ban }
      else
        format.html { render :edit }
        format.json { render json: @ip_ban.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ip_bans/1
  # DELETE /ip_bans/1.json
  def destroy
    @ip_ban.destroy
    respond_to do |format|
      format.html { redirect_to ip_bans_url, notice: 'Ip ban was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ip_ban
      @ip_ban = IpBan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ip_ban_params
      params.require(:ip_ban).permit(:string)
    end
end
