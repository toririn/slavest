require "./config/requires/require"

binding.pry if debug_mode?
slavest_bot1 = Responces::ChatBot.new.botter


bots = [slavest_bot1]

Parallel.each(bots, in_threads: bots.size) do |bot|
  bot.start
end
p "SLAVEST START"
