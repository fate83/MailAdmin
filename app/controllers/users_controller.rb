class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = current_admin.admin? ? User.all : current_admin.users

    authorize! :read, User
    @users.each do |user|
      authorize! :read, user
    end
  end

  # GET /users/new
  def new
    @user = User.new
    authorize! :create, @user
  end

  # GET /users/1/edit
  def edit
    authorize! :update, @user
  end

  def edit_password
    @user = User.find(params[:id])
    authorize! :change_password, @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    authorize! :update, @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'Postfach wurde erfolgreich angelegt!' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'Postfach wurde erfolgreich bearbeitet.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_password
    @user = User.find(params[:id])
    authorize! :change_password, @user

    if @user.update_attributes(user_params)
      redirect_to users_path, notice: 'Passwort wurde erfolgreich bearbeitet!'
    else
      render :edit_password
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    authorize! :destroy, @user
    @user.destroy
    #ToDo: Delete Folder in file system
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Postfach wurde erfolgreich gelöscht!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :domain_id)
    end
end
