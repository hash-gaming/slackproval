require 'http'

class Slack
  attr_reader :api_token, :subdomain, :email
  def initialize(email:)
    @api_token = ENV["SLACK_API_TOKEN"]
    @subdomain = ENV["SLACK_SUBDOMAIN"]
    @email = email
  end

  def send_invite
    return mocked_invite if ENV["MOCK_INVITE"] == "true"
    body = {
      form: {
        email: email,
        token: api_token,
        set_active: true,
        resend: true
      }
    }

    response = HTTP.auth("Bearer #{api_token}").post("https://#{subdomain}.slack.com/api/users.admin.invite", body)
  end

  private
  def mocked_invite
    logger = Logger.new(STDOUT)
    mocked_response = Struct.new(:status)
    logger.info("Mocking invite for #{email}")
    mocked_response.new("200 OK")
  end
end
