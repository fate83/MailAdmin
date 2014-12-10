class AdminsController < ApplicationController
  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new admin_params

    if @admin.save
      redirect_to admins_path, notice: 'Admin wurde erfolgreich angelegt!'
    else
      render :new
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])

    if @admin.update_attributes(admin_params)
      redirect_to admins_path, notice: 'Admin wirde erfolgreich geändert'
    else
      render :edit
    end
  end

  def edit_password
    @admin = Admin.find(params[:id])
  end

  def update_password
    @admin = Admin.find(params[:id])
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    redirect_to admins_path
  end

  private
    def admin_params
      params.require(:admin).permit(:email, :admin, :password, :password_confirmation)
    end
end
