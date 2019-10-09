# user for platform
class User < ApplicationRecord

  # relationship
  has_many :contracts
end
