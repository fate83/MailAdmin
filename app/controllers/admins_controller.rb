class AdminsController < ApplicationController
  def index
    authorize! :manage, Admin
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
    authorize! :manage, @admin
  end

  def create
    @admin = Admin.new admin_params
    authorize! :manage, @admin

    if @admin.save
      redirect_to admins_path, notice: 'Admin wurde erfolgreich angelegt!'
    else
      render :new
    end
  end

  def edit
    @admin = Admin.find(params[:id])
    authorize! :manage, @admin
  end

  def update
    @admin = Admin.find(params[:id])
    authorize! :manage, @admin

    if @admin.update_attributes(admin_params)
      redirect_to admins_path, notice: 'Admin wurde erfolgreich geändert!'
    else
      render :edit
    end
  end

  def edit_password
    @admin = Admin.find(params[:id])
    authorize! :change_password, @admin
  end

  def update_password
    @admin = Admin.find(params[:id])
    authorize! :change_password, @admin

    if @admin.update_attributes(admin_params)
      redirect_to root_path, notice: 'Passwort wurde erfolgreich geändert!'
    else
      render :edit_password
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    authorize! :manage, @admin
    @admin.destroy
    redirect_to admins_path
  end

  private
    def admin_params
      params.require(:admin).permit(:email, :admin, :password, :password_confirmation)
    end
end
