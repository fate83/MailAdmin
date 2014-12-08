class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :trackable, :validatable

  has_many :domains
end
