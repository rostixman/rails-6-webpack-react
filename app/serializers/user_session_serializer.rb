class UserSessionSerializer < ActiveModel::Serializer
  attributes :id, :is_notify, :type
end
