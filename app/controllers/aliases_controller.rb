class AliasesController < ApplicationController
  def index
    @aliases = current_admin.admin? ? Alias.all : current_admin.aliases
  end

  def new
    @alias = Alias.new
  end
end
