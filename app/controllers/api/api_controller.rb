module Api
  class ApiController < ActionController::API
    around_action :handle_exceptions

    # 200 - :ok
    # 204 - :no_content
    # 400 - :bad_request
    # 403 - :forbidden
    # 401 - :unauthorized
    # 404 - :not_found
    # 410 - :gone
    # 422 - :unprocessable_entity
    # 500 - :internal_server_error

    def handle_exceptions
      begin
        yield
      rescue TokenError => e
        @status = :unauthorized
        @message = 'Token is not valid'
      rescue AuthorizedError => e
        @status = :unauthorized
        @message = 'Password or email is not valid'
      rescue JWT::ExpiredSignature => e
        @status = :unauthorized
        UserSession.destroy_by(auth_token: params[:token])
      rescue InvalidDataError => e
        @status = :bad_request
        @message = 'Invalid data'
        @errors = e.errors
      rescue ActiveRecord::RecordNotFound => e
        @status = :not_found
        @message = 'Record not found'
      rescue ActiveRecord::RecordInvalid => e
        @message = 'RecordInvalid'
        @status = :bad_request
      rescue ArgumentError => e
        print 'StandardError'
        @status = :bad_request
      rescue StandardError => e
        print 'StandardError'
        @status = :internal_server_error
      end

      unless e.class == NilClass
        error_response(
          @status,
          @message || e.class.to_s,
          @errors || [e.message]
        )
      end
    end

    def serialize(data, serializer)
      if data.is_a? ActiveRecord::Relation
        ActiveModel::Serializer::CollectionSerializer.new(
          data,
          each_serializer: serializer
        )
      else
        serializer.new(data)
      end
    end

    def success_response(data, meta = {})
      json = { success: true, data: data }
      json[:meta] = meta unless meta.empty?

      json_response(:ok, json)
    end

    def error_response(status, message, errors = [])
      json = { success: false, message: message }
      json[:errors] = errors if errors.any?

      json_response(status, json)
    end

    def json_response(status, json)
      render status: status, json: json
    end

    def plain_response(data)
      render plain: data
    end

    def no_content_response
      render status: :no_content
    end

    def auth
      JsonWebToken.decode(params[:token])
      @token = UserSession.find_by_auth_token(params[:token])
      raise TokenError if @token.nil?
    end
  end
end
