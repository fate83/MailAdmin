class AdminsController < ApplicationController
  def index
    authorize! :manage, Admin
    @admins = Admin.all
  end

  def new
    authorize! :manage, Admin
    @admin = Admin.new
  end

  def create
    authorize! :manage, Admin
    @admin = Admin.new admin_params

    if @admin.save
      redirect_to admins_path, notice: 'Admin wurde erfolgreich angelegt!'
    else
      render :new
    end
  end

  def edit
    authorize! :manage, Admin
    @admin = Admin.find(params[:id])
  end

  def update
    authorize! :manage, Admin
    @admin = Admin.find(params[:id])

    if @admin.update_attributes(admin_params)
      redirect_to admins_path, notice: 'Admin wurde erfolgreich geändert!'
    else
      render :edit
    end
  end

  def edit_password
    authorize! :change_password, Admin
    @admin = Admin.find(params[:id])
  end

  def update_password
    authorize! :change_password, Admin
    @admin = Admin.find(params[:id])

    if @admin.update_attributes(admin_params)
      redirect_to root_path, notice: 'Passwort wurde erfolgreich geändert!'
    else
      render :edit_password
    end
  end

  def destroy
    authorize! :manage, Admin
    @admin = Admin.find(params[:id])
    @admin.destroy
    redirect_to admins_path
  end

  private
    def admin_params
      params.require(:admin).permit(:email, :admin, :password, :password_confirmation)
    end
end
