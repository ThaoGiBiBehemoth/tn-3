class ApplicationController < ActionController::API
  def encode_token(payload)
    payload[:exp] =  30.days.after.to_i
    JWT.encode(payload, 'gibi')
  end

 
end