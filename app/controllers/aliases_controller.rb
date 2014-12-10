class AliasesController < ApplicationController
  def index
    @aliases = current_admin.admin? ? Alias.all : current_admin.aliases
  end

  def new
    @alias = Alias.new
  end

  def create
    @alias = Alias.new(aliases_params)
    authorize! :update, @alias

    respond_to do |format|
      if @alias.save
        format.html { redirect_to aliases_path, notice: 'Alias wurde erfolgreich angelegt!' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @alias = Alias.find(params[:id])
    authorize! :update, @user
  end

  def update
    @alias = Alias.find(params[:id])
    authorize! :update, @alias
    respond_to do |format|
      if @alias.update(aliases_params)
        format.html { redirect_to aliases_path, notice: 'Alias wurde erfolgreich bearbeitet.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def aliases_params
      params.require(:alias).permit(:user_source, :domain_source_id, :user_destination_id, :domain_destination_id)
    end
end
