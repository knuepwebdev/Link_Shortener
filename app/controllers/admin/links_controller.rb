class Admin::LinksController < ApplicationController
  # Only allow Admin users to access admin endpoints
  # before_action :authenticate_admin
  before_action :find_link, only: [:edit, :update, :show]

  def edit
    return render "edit"
  end

  def update
    return render @link if @link.update_attributes(link_params)
  end

  def show
    return render partial: "layouts/not_found", status: :not_found if !@link.is_active
    @link.update_attributes(usage_count: @link.usage_count += 1)
    return render @link
  end  

  private
  def link_params
    params.require(:link).permit(:is_active)
  end
end
