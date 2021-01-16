# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_many :books, dependent: :destroy
  has_one_attached :avatar

  has_many :following_relationships, inverse_of: 'follower',
                                  class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy

  has_many :follower_relationships, inverse_of: 'followed',
                                   class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy

  has_many :followees, through: :following_relationships, source: :followed
  has_many :followers, through: :follower_relationships, source: :follower

  validates :uid, uniqueness: { scope: :provider }, allow_nil: true

  def self.find_for_oauth(auth)
    user = User.find_by(uid: auth.uid, provider: auth.provider)

    user ||= User.create(
      uid: auth.uid,
      provider: auth.provider,
      username: auth.info.nickname,
      email: User.dummy_email(auth),
      password: Devise.friendly_token[0, 20]
    )
    user
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

  # ユーザーをフォローする
  def follow(other_user)
    followees << other_user
  end

  # ユーザーのフォローを解除する
  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在フォローしているか確認する
  def followees?(other_user)
    followees.include?(other_user)
  end
end
