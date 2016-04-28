require "./config/requires/require"

slavest_bot1 = ResponceBot.new.botter
slavest_bot2 = SampleBot.new.botter

bots = [slavest_bot1, slavest_bot2]

Parallel.each(bots, in_threads: bots.size) do |bot|
  bot.start
end
