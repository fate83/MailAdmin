class Alias < ActiveRecord::Base
  belongs_to :domain_source, class_name: Domain
  belongs_to :domain_destination, class_name: Domain
  belongs_to :user_destination, class_name: User
end
