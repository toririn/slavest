class SampleBot < BaseBot
  private

  def set
    @botter.set_condition( channel: "times_toririn", user: ["toririn"], text: ["こんにちは"])
    @botter.set_responce(channel: "times_toririn", user: "Slavest", text: "こんにちは！")
  end
end
