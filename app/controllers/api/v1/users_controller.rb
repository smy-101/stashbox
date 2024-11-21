class Api::V1::UsersController < BaseController
  before_action :authenticate_user, only: [ :me, :update ]

  def create
    user = User.new(user_params)
    if user.save
      token = jwt_encode(user.id)
      render_success({
            user: user.as_json(except: :password_digest),
            token: token
          }, :created)
    else
      render_error(:unprocessable_entity, user.errors.full_messages)
    end
  end

  def me
    render_success(current_user.as_json(except: :password_digest))
  end

  def update
    if current_user.update(user_update_params)
      render_success(current_user.as_json(except: :password_digest))
    else
      render_error(:unprocessable_entity, current_user.errors.full_messages)
    end
  end

   private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end

  def user_update_params
    params.require(:user).permit(:name, :email)
  end
end
