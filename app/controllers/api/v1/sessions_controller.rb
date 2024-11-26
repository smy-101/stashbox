class Api::V1::SessionsController < ApplicationController
  # POST /api/v1/sessions
  def create
    user = User.find_by(email: login_params[:email])
    if user&.authenticate(login_params[:password])
      render json: { jwt: user.generate_jwt, email: user.email }, status: :ok
    else
      render json: { error: "邮箱或密码错误" }, status: :unauthorized
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
