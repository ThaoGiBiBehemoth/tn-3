class UsersController < ApplicationController
  before_action :authorize, only: [:index, :update, :destroy]
  before_action :set_user, only: [:index, :update, :destroy]


  # SHOW EACH INFO
  def index
    # @users = User.all
    render json: { user: @user},  status: 200
  end



  # SIGNUP
  def create
    @user = User.create(user_params)

    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token},  status: 200
    else
      render json: { error: 'Invalid!!!' }, status: :unprocessable_entity
    end
  end

  #LOGIN
  def login
    @user = User.find_by(nick: user_params[:nick])
    if @user && @user.authenticate(user_params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: 422
    end
  end

  # UPDATE
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE 
  def destroy
    @user.destroy
  end

  private
    def user_params
      params.require(:user).permit(:nick, :password, :email)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
end