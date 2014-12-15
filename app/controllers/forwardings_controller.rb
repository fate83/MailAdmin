class ForwardingsController < ApplicationController
  def index
    @forwardings = current_admin.admin? ? Forwarding.all : current_admin.forwardings

    authorize! :read, Alias
    @forwardings.each do |a|
      authorize! :read, a
    end
  end

  def new
    @forwarding = Forwarding.new
  end

  def create
    @forwarding = Forwarding.new(forwardings_params)
    authorize! :update, @forwarding

    respond_to do |format|
      if @forwarding.save
        format.html { redirect_to forwardings_path, notice: 'Weiterleitung wurde erfolgreich eingerichtet!' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @forwarding = Forwarding.find(params[:id])
    authorize! :update, @forwarding
  end

  def update
    @forwarding = Forwarding.find(params[:id])
    authorize! :update, @forwarding
    respond_to do |format|
      if @forwarding.update(forwardings_params)
        format.html { redirect_to forwardings_path, notice: 'Weiterleitung wurde erfolgreich bearbeitet.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @forwarding = Forwarding.find(params[:id])
    authorize! :destroy, @forwarding
    @forwarding.destroy
    redirect_to forwardings_path
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def forwardings_params
    params.require(:forwarding).permit(:user_id, :domain_id, :destination)
  end
end
