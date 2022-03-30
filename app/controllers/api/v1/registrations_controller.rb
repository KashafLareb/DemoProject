class Api::V1::RegistrationsController < Api::V1::ApiController
  def create
    @user = User.new(user_params)
    if @user.save
      token = JsonWebToken.encode(@user.id)
      render json: { token: token, email: @user.email }, status: :ok
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
    render json: @users
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
