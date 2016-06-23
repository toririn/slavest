# User が Slack に対して操作を行ったときに反応する Bot を集めた Module
module Responces

  # ユーザに自分の感情値の平均値を返す
  class AverageEmovalueBot < BaseBot

    def set
      set_receive_condition
      set_responce_condition
    end

    private

    # 指定したチャンネルの全てのユーザの全ての投稿を起動条件とする
    def set_receive_condition
      channels = %W(times_toririn)
      @botter.set_condition( channel: channels)
    end


    # 投稿されたチャットの内容が「@slavest or @sv」で始まり
    # なおかつ 「average or ave」という文字が入っていれば
    # 感情平均値を返すAPIのURLに「投稿者、投稿チャンネル、投稿内容、登録日時（タイムスタンプ）」を送る
    def set_responce_condition
      @botter.set_responce do |data, res|
        if data.present? && fit_text?(data["text"])
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
      rails[:urls][:base] + rails[:paths][:everests][:show]
    end

    def add_api_token(data)
      data.merge(api_token: Settings[:slavest][:api_token])
    end

    # textの先頭が @sv もしくは @slarest で始まり、 average もしくは ave が文中にあれば true を返す
    def fit_text?(text)
      refine_text = text.gsub(/　|\s|\n/, "").strip.downcase
      mention_valid = refine_text.match(/\A@st|\A@slarest/) rescue false
      average_valid = refine_text.match(/average|ave/) rescue false

      mention_valid && average_valid
    rescue => ex
      puts "#{ex}\nparam: #{text}"
      false
    end
  end
end
