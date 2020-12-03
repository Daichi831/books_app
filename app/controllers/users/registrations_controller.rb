# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def after_update_path_for(_resource)
      user_path(current_user)
    end

    protected
    def update_resource(resource, params)
      if params[:password].present? && params[:password_confirmation].present?
        resource.update_attributes(params)
      else
        resource.update_without_password(params)
      end
    end
  end
end
