class ApplicationController < ActionController::API
  def encode_token(payload)
    payload[:exp] =  30.days.after.to_i
    JWT.encode(payload, 'gibi')
  end

  def decode_token
    auth_header = request.headers['Authorization']

    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'gibi', true, alg: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def authorized_user
    decoded_token = decode_token()
    if decoded_token
      user_id = decode_token[0]['user_id']
      @user = User.find_by_id(user_id)
    end
  end

  def authorize
    unless authorized_user
      render json: { message: 'You must log in.' }, status: 422
    end
  end
end