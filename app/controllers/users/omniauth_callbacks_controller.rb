# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def github
      callback_from :github
    end

    private

    def callback_from(provider)
      @user = User.find_for_oauth(request.env['omniauth.auth'])

      if @user.persisted?
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.to_s.capitalize)
        sign_in_and_redirect @user, event: :authentication
      else
        redirect_to new_user_registration_path
      end
    end
  end
end
