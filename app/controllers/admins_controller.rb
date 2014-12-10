class AdminsController < ApplicationController
  def index
    @admins = Admin.all
  end

  def new
  end
end
