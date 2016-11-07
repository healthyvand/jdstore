class Admin::AnliysisesController < ApplicationController
  before_action :authenticate_user! , only: [:index]
  before_action :admin_required

  layout "admin"
  def index
    
  end

  private



  def admin_required
    if !current_user.admin?
        redirect_to '/'
    end
  end

end
