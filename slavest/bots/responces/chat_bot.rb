# User が Slack に対して操作を行ったときに反応する Bot を集めた Module
module Responces

  # Chat に対するレスポンス例
  class ChatBot < BaseBot

    def set
      set_receive_condition
      set_responce_condition
    end

    private

    def set_receive_condition
      @botter.set_condition( channel: "times_toririn", user: ["toririn"], text: [/\A@slavest/, /\A@sv/])
    end


    def set_responce_condition
      @botter.set_responce do |data, res|
        params = data.to_json
        HCLIENT.post_content(post_url, params, 'Content-Type' => 'application/json')
        nil
      end
    end

    def post_url
      rails = Settings[:slavest][:rails]
      rails[:urls][:base] + rails[:paths][:test]
    end
  end
end
