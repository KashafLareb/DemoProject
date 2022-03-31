class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error

  def current_user
    @current_user
  end

  protected
    def authenticate
      authenticate_token || not_authenticated
    end

    def unprocessable_entity(errors)
      render json: { errors: errors }, status: :unprocessable_entity
      return
    end

    def not_authenticated
      render json: { errors: ['user not authorized'] }, status: :unauthorized
      return
    end

    def authenticate_token
      return false unless user_id_in_token?
      @current_user = User.find_by(id: access_token[:id])
      return false unless @current_user.present?
      true
    end

  private
    def record_not_found_error
      render json: { errors: ['Object was not found'] }, status: :not_found
    end

    def http_token
      @http_token = request.headers['ACCESS-TOKEN']
    end

    def access_token
      @access_token = JsonWebToken.decode(http_token)
    end

    def user_id_in_token?
      http_token && access_token && !access_token.is_a?(String) && access_token[:id].to_i
    end
end
