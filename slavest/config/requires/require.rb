require "./config/requires/gems"

require_dir = ["config/initializers", "lib", "conditions", "bots", "bots/responces"]

require_dir.each do |dir|
  Dir.glob("./#{dir}/*.rb").each do |file|
    require file
  end
end
