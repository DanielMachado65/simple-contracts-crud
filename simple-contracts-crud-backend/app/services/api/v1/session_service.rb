module Api
  module V1
    # session service
    class SessionService
      # verify by email already registered
      def self.email(params)
        return nil unless params[:embaixador][:email].present? || params[:embaixador].present?
        Embaixador.find_by(email: params[:embaixador][:email])
            .presence
      end

      # don't have fb_id existing
      def self.verify(params)
        ambassador = email(params).presence
        return {registered: false} if ambassador.nil?

        ambassador.fb_id? ? {registered: true, type: 'facebook'} : {registered: true, type: 'email'}
      end

      def self.completed?(ambassador, from_portal = false)
        ambassador_data = ambassador.as_json(only: %i(nome email slug auth_token))
        ambassador_data['auth_token'] = ambassador.auth_token_portal if from_portal
        json = ambassador_data
        json['completed'] = ambassador.music_genres.present? && ambassador.cidade.present?
        json
      end
    end
  end
end
