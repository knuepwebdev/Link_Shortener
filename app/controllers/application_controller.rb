class ApplicationController < ActionController::Base
  def find_link
    @link ||= Link.find(params[:id])
  end
end
