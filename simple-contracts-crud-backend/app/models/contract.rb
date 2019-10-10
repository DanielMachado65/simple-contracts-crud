# contract for user
class Contract < ApplicationRecord

  belongs_to :user

  # pdf
  has_one_attached :pdf
end
