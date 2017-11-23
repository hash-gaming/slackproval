class DomainBansController < ApplicationController
  before_action :set_domain_ban, only: [:show, :edit, :update, :destroy]

  # GET /domain_bans
  # GET /domain_bans.json
  def index
    @domain_bans = DomainBan.all
  end

  # GET /domain_bans/1
  # GET /domain_bans/1.json
  def show
  end

  # GET /domain_bans/new
  def new
    @domain_ban = DomainBan.new
  end

  # GET /domain_bans/1/edit
  def edit
  end

  # POST /domain_bans
  # POST /domain_bans.json
  def create
    @domain_ban = DomainBan.new(domain_ban_params)

    respond_to do |format|
      if @domain_ban.save
        format.html { redirect_to @domain_ban, notice: 'Domain ban was successfully created.' }
        format.json { render :show, status: :created, location: @domain_ban }
      else
        format.html { render :new }
        format.json { render json: @domain_ban.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /domain_bans/1
  # PATCH/PUT /domain_bans/1.json
  def update
    respond_to do |format|
      if @domain_ban.update(domain_ban_params)
        format.html { redirect_to @domain_ban, notice: 'Domain ban was successfully updated.' }
        format.json { render :show, status: :ok, location: @domain_ban }
      else
        format.html { render :edit }
        format.json { render json: @domain_ban.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /domain_bans/1
  # DELETE /domain_bans/1.json
  def destroy
    @domain_ban.destroy
    respond_to do |format|
      format.html { redirect_to domain_bans_url, notice: 'Domain ban was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain_ban
      @domain_ban = DomainBan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def domain_ban_params
      params.require(:domain_ban).permit(:string)
    end
end
