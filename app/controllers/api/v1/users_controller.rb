class Api::V1::UsersController < Api::V1::BaseController
  # before_action :authenticate_user, only: [ :me, :update ]

  def create
    user = User.new(user_params)
    if user.save
      token = jwt_encode(user.id)
      render_success(:created, {
            user: user.as_json(except: :password_digest),
            token: token
          })
    else
      render_error(:unprocessable_entity, user.errors.full_messages)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
