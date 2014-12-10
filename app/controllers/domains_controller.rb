class DomainsController < ApplicationController

  def index
    authorize! :manage, Domain
    @domains = Domain.all
  end

  def new
    authorize! :manage, Domain
    @domain = Domain.new
  end

  def create
    authorize! :manage, Domain
    @domain = Domain.new domain_params

    if @domain.save
      redirect_to domains_path, notice: 'Domain wurde erfolgreich angelegt!'
    else
      render :new
    end
  end

  def edit
    authorize! :manage, Domain
    @domain = Domain.find(params[:id])
  end

  def update
    authorize! :manage, Domain
    @domain = Domain.find(params[:id])

    if @domain.update_attributes(domain_params)
      redirect_to domains_path, notice: 'Domain wurde erfolgreich geändert!'
    else
      render :edit
    end
  end

  def destroy
    authorize! :manage, Domain
    @domain = Domain.find(params[:id])
    @domain.destroy
    redirect_to domains_path
  end

  private
    def domain_params
      params.require(:domain).permit(:name, :admin_id)
    end
end
