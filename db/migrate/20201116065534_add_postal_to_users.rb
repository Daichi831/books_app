# frozen_string_literal: true

class AddPostalToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :postal, :integer
  end
end
