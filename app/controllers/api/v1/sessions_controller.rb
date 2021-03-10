module Api
  module V1
    class SessionsController < ApiController
      before_action :auth, only: [:destroy]

      def create
        args = create_params

        user = User.find_by_email(args.fetch(:email, '').downcase)
        if user.nil? || !user.valid_password?(args[:password])
          raise AuthorizedError
        end

        token = user.sign_in(args[:gadget_type],
                             args[:gadget_uid])
        success_response(token)
      end

      def destroy
        @token&.destroy
      end

      private

      def create_params
        params.require(%i[email password gadget_type])
        params.permit(%i[email password gadget_uid gadget_type])
      end
    end
  end
end
