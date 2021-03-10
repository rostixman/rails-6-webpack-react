module Api
  module V1
    class UsersController < ApiController
      before_action :auth, only: %i[list show destroy]

      def create
        args = create_params
        query_params = {}
        query_params[:email] = args.fetch(:email, '').downcase
        query_params[:password] = args[:password]
        query_params[:password_confirmation] = args[:password]
        query_params[:user_role] = User.user_roles[:user]

        user = User.new(query_params)

        raise InvalidDataError, user.errors.full_messages unless user.valid?

        user.save
        token = user.sign_in(args[:gadget_type],
                             args[:gadget_uid])

        success_response(token)
      end

      def list
        data = serialize(User.all, UserSerializer)
        success_response(data)
      end

      def show
        user = User.find(show_params[:id])

        data = serialize(user, UserSerializer)
        success_response(data)
      end

      def destroy
        @token&.user&.destroy
      end

      private

      def create_params
        params.require(%i[email password gadget_type])
        params.permit(%i[email password gadget_uid gadget_type])
      end

      def show_params
        params.require(:id)
        params.permit(:id)
      end
    end
  end
end
