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

    # ユーザが投稿した Chat に文字列を付加してそのままオウム返しにする
    def set_responce_condition
      @botter.set_responce do |data, res|
        user, channel, text = data["user"], data["channel"], data["text"] rescue nil
        text.gsub!(/\A@slavest|\A@sv/, "").gsub!(/\A\n/, "") rescue nil
        text = "「#{text}」\nですね。それでそれで？"
        if text.present?
          @poster.channel(to: "times_toririn", text: text, name: "slavest")
        end
        nil
      end
    end
  end
end
