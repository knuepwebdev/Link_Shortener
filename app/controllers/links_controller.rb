class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    link = Link.create(link_params)
    return redirect_to link
  end

  def show
    @link = Link.find(params[:id])
    @link.update_attributes(usage_count: @link.usage_count += 1)
    return render @link
  end

  private
  def link_params
    params.require(:link).permit(:long_url)
  end
end
