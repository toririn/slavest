class ResponceBot < BaseBot
  private

  def set
    @botter.set_condition( channel: "times_toririn", user: ["toririn"], text: [/\A@slavest/, /\A@sv/])
    @botter.set_responce(channel: "times_toririn", user: "Slavest", text: "none") do |data, res|
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
