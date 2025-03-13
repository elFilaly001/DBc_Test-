class UsersController < ApplicationController

  skip_before_action :verify_authenticity_token

  # GET /users
  def index
    users = User.all
    render json: users
  end

  # GET /users/:id
  def show
    user = User.find(params[:id])
    render json: user
  end

  # POST /users
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # PUT /users/:id
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    user = User.find(params[:id])
    user.destroy
    head :no_content
  end


  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: user
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end
  private

  # Strong parameters to allow only the required fields
  def user_params
    params.permit(:email, :password)
  end
  
end
