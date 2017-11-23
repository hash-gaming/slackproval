class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy, :approve, :deny]
  before_action :authentication_check, only: [:show, :index, :update, :edit, :destroy, :approve, :deny, :approved, :denied]
  before_action :require_admin, only: [:audit_log]

  # GET /requests
  # GET /requests.json
  def index
    @requests = case params[:filter]
    when "approved"
      Request.approved.page(params[:page])
    when "denied"
      Request.denied.page(params[:page])
    else
      Request.new_items.page(params[:page])
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  def audit_log
    @audits = Audited::Audit.where(auditable_type: "Request").page(params[:page])
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to root_path, notice: 'Request submitted for approval' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve
    @request.update status: 'approved'
    redirect_to requests_url(filter: params[:filter]), notice: "Approved #{@request.email}"
  end

  def deny
    if @request.approved?
      redirect_to requests_url(filter: params[:filter]), notice: 'Approved request cannot be denied.'
    else
      @request.update status: 'denied'
      redirect_to requests_url(filter: params[:filter]), notice: "Denied #{@request.email}"
    end
  end

  def approve_all
    Request.new_items.each do |request|
      request.update status: 'approved'
    end
    redirect_to requests_url, notice: 'All requests approved'
  end

  def deny_all
    Request.new_items.each do |request|
      request.update status: 'denied'
    end
    redirect_to requests_url, notice: 'All requests denied'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:email, :reason, :status)
    end
end
