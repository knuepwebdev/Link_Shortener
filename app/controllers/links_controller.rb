class LinksController < ApplicationController
  before_action :find_link, only: [:show, :decode]
  rescue_from ActiveRecord::RecordNotFound do |ex|
    render partial: "layouts/not_found", status: :not_found
  end

  def new
    @link = Link.new
  end

  def create
    link = Link.new(link_params)
    return redirect_to link if link.save
    return redirect_to new_link_url, flash: { error: link.errors.messages[:long_url] }
  end

  def show
    return render "show"
  end

  def decode
    return render partial: "layouts/not_found", status: :not_found if !@link.is_active
    @link.update_attributes(usage_count: @link.usage_count += 1)
    return redirect_to @link.long_url
  end

  private
  def link_params
    params.require(:link).permit(:long_url)
  end
end
