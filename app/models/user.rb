class User < ActiveRecord::Base
  belongs_to :domain
  has_many :aliases, foreign_key: :user_source_id
end
