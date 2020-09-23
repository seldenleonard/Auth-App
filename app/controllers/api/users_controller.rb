class Api::UsersController < ApplicationController

  before_action :authenticate_user, except: [:create]

  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.save
      render "show.json.jb"
      render json: {message: "User created successfully"}, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: 422
    end
  end

  def show
    if @user = current_user
      render "show.json.jb"
    else
      render json: {errors: @user.errors.full_messages}, status: 422
    end
  end

end