class User < ApplicationRecord
  # Include default devise modules.
  # devise :database_authenticatable, :registerable,
  #         :recoverable, :rememberable, :trackable, :validatable
  #        # :confirmable, :omniauthable
  # include DeviseTokenAuth::Concerns::User
  #
  # def generate_auth_token
  #   token = SecureRandom.hex
  #   self.update_columns(auth_token: token)
  #   token
  # end
  #
  # def invalidate_auth_token
  #   self.update_columns(auth_token: nil)
  # end
end
