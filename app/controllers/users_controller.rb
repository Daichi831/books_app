# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[mypage edit update]
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.all
  end

  def mypage
    redirect_to user_path(current_user)
  end

  def show; end

  def edit
    if @user == current_user
      redirect_to edit_user_registration_path(current_user)
    # 編集するユーザーが本人じゃない場合はユーザーページにリダイレクトする
    else
      redirect_to user_path(@user)
    end
  end

  def update
    # アップデートがうまくいけば、マイページに戻利、
    # うまくいかなければ、もう一度編集ページを表示する
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user, {}).permit(:username)
  end
end
