require 'erb'
settings_erb = ERB.new(File.read("./config/setting.yml")).result
settings_yml = YAML::load(settings_erb)
Settings = HashWithIndifferentAccess.new(settings_yml)
