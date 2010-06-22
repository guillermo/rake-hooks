Gem::Specification.new do |s|
  s.name = "rake-hooks"
  s.version = "0.1"
  s.date = "2010-06-22"
  s.authors = ["Guillermo Álvarez"]
  s.email = "guillermo@cientifico.net"
  s.summary = "Add after and before hooks to rake tasks"
  s.homepage = "http://github.com/guillermo/rake-hooks"
  s.description = "Add after and before hooks to rake tasks. You can use \"after :task do ... end\" and \"before :task do ... end\"."
  s.files = [ "README", "LICENSE", "Rakefile", "test/test_rake_hooks.rb", "lib/rake/hooks.rb"]
end
