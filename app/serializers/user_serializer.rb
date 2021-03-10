class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :role

  has_many :sessions, class_name: 'UserSessionSerializer'
end
