class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :trackable, :validatable

  has_many :domains
  has_many :users, through: :domains
  has_many :aliases, through: :users
  has_many :forwardings, through: :users
end
