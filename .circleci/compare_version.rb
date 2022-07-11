require "rubygems"

spec = Gem::Specification::load("rubocop-amagi.gemspec")
puts spec.version

abort("Git Tag and SidekiqDupGuard version doesn't match") if (ENV["CIRCLE_TAG"].sub(/^v/, "") != version)

exit(0)
