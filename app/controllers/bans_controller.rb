class BansController < ApplicationController
  before_action :set_ban, only: [:show, :edit, :update, :destroy]
  before_action :authentication_check
  before_action :require_admin, only: [:audit_log]

  # GET /bans
  # GET /bans.json
  def index
    @bans = Ban.all.order('created_at DESC').page(params[:page])
  end

  # GET /bans/1
  # GET /bans/1.json
  def show
  end

  # GET /bans/new
  def new
    @ban = Ban.new
  end

  # GET /bans/1/edit
  def edit
  end

  def audit_log
    @audits = Audited::Audit.where(auditable_type: "Ban").page(params[:page])
  end

  # POST /bans
  # POST /bans.json
  def create
    @ban = Ban.new(ban_params)

    respond_to do |format|
      if @ban.save
        format.html { redirect_to bans_path, notice: 'Ban was successfully created.' }
        format.json { render :show, status: :created, location: @ban }
      else
        format.html { render :new }
        format.json { render json: @ban.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bans/1
  # PATCH/PUT /bans/1.json
  def update
    respond_to do |format|
      if @ban.update(ban_params)
        format.html { redirect_to bans_path, notice: 'Ban was successfully updated.' }
        format.json { render :show, status: :ok, location: @ban }
      else
        format.html { render :edit }
        format.json { render json: @ban.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bans/1
  # DELETE /bans/1.json
  def destroy
    @ban.destroy
    respond_to do |format|
      format.html { redirect_to bans_url, notice: 'Ban was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ban
      @ban = Ban.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ban_params
      params.require(:ban).permit(:ban_type, :ban_value)
    end
end
