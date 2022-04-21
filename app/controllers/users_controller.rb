class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    user = get_user_from_token
    render json: {
      message: 'User data.',
      data: user
    }
  end

  private

  def get_user_from_token
    token = request.headers["Authorization"].split(' ')[1]
    secret = 'SECRET' #TODO: migrate to application.yml (ver aula Diego)
    jwt_payload = JWT.decode(token, secret).first
    user_id = jwt_payload['sub']
    user = User.find(user_id.to_s)
  end
end