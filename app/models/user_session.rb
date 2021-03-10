class UserSession < ApplicationRecord
  belongs_to :user
  enum gadget_type: {
    ios: 'ios',
    android: 'android',
    browser: 'browser'
  }

  def type
    gadget_type
  end
end
