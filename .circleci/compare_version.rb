require "rubygems"

version = Gem::Specification::load("rubocop-amagi.gemspec").version.to_s
puts version

abort("Git Tag and rubocop-amagi gem version doesn't match") if (ENV["CIRCLE_TAG"].sub(/^v/, "") != version)

exit(0)
