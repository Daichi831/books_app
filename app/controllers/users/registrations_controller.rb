# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def after_update_path_for(_resource)
      user_path(current_user)
    end
  end
end
