module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
  end

  module TokenHelpers
    def make_token_header(user)
      token = controller.encode_token(user_id: user.id)
      request.headers[:Authorization] = "Bearer #{token}"
    end
  end
end
