# controller for user
class Api::V1::UserController < Api::V1::ApiController

  before_action :require_auth_token, except: %i(create)

  def create
    binding.pry
  end
end