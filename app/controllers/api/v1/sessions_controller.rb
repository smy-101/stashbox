class Api::V1::SessionsController < BaseController
  before_action :authenticate_user!, only: [ :destroy ]

  # POST /api/v1/sessions
  def create
    user = User.find_by(email: login_params[:email])

    if user&.authenticate(login_params[:password])
      token = jwt_encode(user_id: user.id)
      render_success({
            user: user.as_json(except: :password_digest),
            token: token
          }, :created)
    else
      render_error(:unauthorized, "邮箱或密码错误")
    end
  end

  # DELETE /api/v1/sessions
  def destroy
    # JWT是无状态的，客户端删除token即可
    # 这里可以添加token黑名单等额外功能
    render_success(message: "已成功登出")
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
