class User < ApplicationRecord
  include ActiveModel::Validations

  validates :name, :password, presence: true
  validates_with StrongPasswordChecker
end
