class ErrorsController < ApplicationController
  def show
    @code = status_code
    render :show, status: @code
  end

  protected

  def status_code
    params[:code] || 500
  end
end
