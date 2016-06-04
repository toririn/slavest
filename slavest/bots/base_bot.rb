# Slavestで起動するBot Class の Base となる Class
class BaseBot

  # SimpleSlack module で生成される各 Class への参照
  attr_reader :client, :botter, :getter, :poster

  # Bot Class は全て getter, poster, botter への参照ができる。
  # また initialize のタイミングで set メソッドが呼ばれることで bot で反応する条件やレスポンス条件をセットする。
  def initialize
    @client = SimpleSlack::Client.new(CONFIG["slack"]["api_token"])
    @getter = client.get
    @poster = client.post
    @botter = client.bot
    set
  end

  # BaseBot Class を継承した Bot Class は全て set メソッドを実装すること
  def set
  end

end
