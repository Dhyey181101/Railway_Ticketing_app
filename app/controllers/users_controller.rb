class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    if current_user.admin
      @users = User.all
    else
      redirect_to root_path
    end
  end

  # GET /users/1 or /users/1.json
  def show
    if current_user.id != @user.id && !current_user.admin
      redirect_to root_path
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if current_user.id != @user.id && !current_user.admin
      redirect_to root_path
    end
    if @user.admin?
      respond_to do |format|
        format.html { redirect_to users_url, notice: "Cannot Edit the admin user." }
        format.json { head :no_content }
      end
    end
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: "User was successfully created. Try Loggin in now." }
        format.json { render root_path, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    if @user.admin?
      respond_to do |format|
        format.html { redirect_to users_url, alert: "Cannot delete the admin user." }
        format.json { head :no_content }
      end
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :username, :email_address, :password, :password_confirmation, :address, :phone_number, :credit_card)
    end
end
