Gem::Specification.new do |s|
  s.name        = 'rubocop-amagi'
  s.version     = '1.0.0'
  s.platform    = Gem::Platform::RUBY

  s.summary     = 'amagi rubocop rules'
  s.description = 'amagi rubocop rules'
  s.homepage    = 'https://github.com/amagimedia/rubocop-amagi'
  s.license     = ''
  s.authors     = ['Cloudport Team']
  s.email       = 'cloudport.team@amagi.com'

  s.files       = ['rubocop.yml'] + `git ls-files | grep -E '^(lib)'`.split("\n")
end
