class User < ActiveRecord::Base
  before_save :encrypt_password

  belongs_to :domain
  has_many :aliases, foreign_key: :user_destination_id
  has_many :forwardings

  private
    def encrypt_password
      `yes "#{self.password}" | doveadm pw -s SHA512-CRYPT` =~ /\{SHA512-CRYPT\}(.*)/
      self.password = $1
    end
end
