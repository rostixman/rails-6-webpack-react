class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable,              :rememberable,
         :validatable

  enum user_role: {
    admin: 'admin',
    user: 'user'
  }

  has_many :sessions, class_name: 'UserSession', dependent: :delete_all

  def role
    user_role
  end

  def sign_in(type, uid = nil)
    payload = { data: { user_id: id, email: email, user_role: user_role } }
    token = JsonWebToken.encode payload
    UserSession.create(
      user_id: id,
      gadget_uid: uid,
      gadget_type: type,
      auth_token: token
    )

    token
  end
end
