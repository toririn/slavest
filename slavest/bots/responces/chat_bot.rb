# User が Slack に対して操作を行ったときに反応する Bot を集めた Module
module Responces

  # Chat に対するレスポンス例
  class ChatBot < BaseBot

    def set
      set_receive_condition
      binding.pry if debug_mode?
      set_responce_condition
    end

    private

    def set_receive_condition
      @botter.set_condition( channel: "times_toririn", user: ["toririn"], text: [/\A@slavest/, /\A@sv/])
    end


    def set_responce_condition
      @botter.set_responce do |data, res|
        if data.present?
          begin
            hc = HTTPClient.new
            params = add_api_token(data).to_json
            result = hc.post_content(post_url, params, 'Content-Type' => 'application/json')
            puts result
          rescue => e
            puts e
          end
        end
      end
    end

    def post_url
      rails = Settings[:slavest][:rails]
      rails[:urls][:base] + rails[:paths][:everests][:new]
    end

    def add_api_token(data)
      data.merge(api_token: Settings[:slavest][:rails][:api_token])
    end
  end
end
