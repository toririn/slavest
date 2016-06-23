require "./config/requires/require"

binding.pry if debug_mode?
slarest_bot1 = Responces::ChatBot.new.botter
slarest_bot2 = Responces::AverageEmovalueBot.new.botter


bots = [slarest_bot1, slarest_bot2]

Parallel.each(bots, in_threads: bots.size) do |bot|
  bot.start
end
