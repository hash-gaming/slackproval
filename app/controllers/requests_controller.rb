class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy, :approve, :deny]
  before_action :authentication_check, only: [:show, :index, :update, :edit, :destroy, :approve, :deny, :approved, :denied]
  before_action :require_admin, only: [:audit_log]

  # GET /requests
  # GET /requests.json
  def index
    @requests = case params[:filter]
    when "approved"
      Request.approved.search(params[:query]).order('created_at DESC').page(params[:page])
    when "denied"
      Request.denied.search(params[:query]).order('created_at DESC').page(params[:page])
    else
      Request.new_items.search(params[:query]).order('created_at DESC').page(params[:page])
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
    @request.ip = request.remote_ip

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
        format.html { redirect_to requests_path, notice: 'Request was successfully updated.' }
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
    @request.update status: 'deleted'
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve
    if @request.update status: 'approved'
      response = Slack.new(email: @request.email).send_invite
      if response.status.to_s == "200 OK"
        redirect_to requests_url(filter: params[:filter]), notice: "Approved #{@request.email}"
      else
        redirect_to requests_url(filter: params[:filter]), notice: "Something went wrong"
      end
    else
      redirect_to requests_url(filter: params[:filter]), notice: "Something went wrong"
    end
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
    approved = 0
    errored = 0
    Request.new_items.each do |request|
      if request.update status: 'approved'
        response = Slack.new(email: request.email).send_invite
        if response.status.to_s == "200 OK"
          approved += 1
        else
          errored += 1
        end
      else
        errored += 1
      end
    end
    redirect_to requests_url, notice: "#{approved} requests approved. #{errored} requests errored"
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
      params.require(:request).permit(:email, :reason, :status, :query, :code_of_conduct)
    end
end
