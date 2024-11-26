class Api::V1::BaseController < ApplicationController
  include JwtAuthentication

  # skip_before_action :verify_authenticity_token

  private

  def render_error(status, message)
    render json: { error: message }, status: status
  end

  def render_success(status, message)
    render json: { message: message }, status: status
  end
end
