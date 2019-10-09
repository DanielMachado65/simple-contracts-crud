module Api
  module V1
    # user service
    class UserService

      def self.create(attrs = {})
        params = user_params(attrs)
        return {code: 400, error: error} unless params.permitted?

        create_user(params)
      end


      private

      def self.user_params(params)
        params.require(:user).permit(:first_name, :last_name, :email, :password,
                                     :cpf, :telephone)
      end

      def self.create_user(attrs)
        @user = User.create(attrs)
        return {code: 400, error: @user.errors.as_json} if @user.errors.present?

        @user.regenerate_token
        @user.as_json(only: :auth_token)
      end
    end
  end
end
