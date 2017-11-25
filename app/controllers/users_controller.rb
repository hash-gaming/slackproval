class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with :name => ENV.fetch("ADMIN_USERNAME", "admin"), :password => ENV["ADMIN_PASSWORD"], only: :new
  before_action :authentication_check, except: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    redirect_to root_path if current_user != @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.admin = true if @user.email == ENV["DEFAULT_ADMIN_EMAIL"]

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    redirect_to root_path if current_user != @user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    redirect_to root_path if current_user != @user || current_user.admin?
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
