class RequestsController < ApplicationController
    before_action :set_request, only: %i[update]
  def update
    @request.status = 'active'
    @request.save
    redirect_to dashboard_path(anchor: "request_#{@request.id}"), notice: 'Request successfully updated'
  end
  def set_request
    @request = Request.find(params[:id])
  end
end
