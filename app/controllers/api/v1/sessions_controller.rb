class Api::V1::SessionsController < Api::V1::ApiController
  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user.present?
      token = JsonWebToken.encode({id: @user.id})
      render json: { token: token, email: @user.email }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def index
    @users = User.all
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
