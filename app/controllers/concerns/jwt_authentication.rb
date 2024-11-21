module JwtAuthentication
  extend ActiveSupport::Concern

  included do
    # 在需要认证的控制器中使用
    attr_reader :current_user
  end

  private

  def authenticate_user!
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      decoded = jwt_decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: "未授权的访问" }, status: :unauthorized
    end
  end

  def jwt_encode(payload)
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
    HashWithIndifferentAccess.new(decoded)
  end
end
