# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{heroku}
  s.version = "2.39.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Heroku"]
  s.date = %q{2013-05-29}
  s.description = %q{Client library and command-line tool to deploy and manage apps on Heroku.}
  s.email = %q{support@heroku.com}
  s.executables = ["heroku"]
  s.files = ["bin/heroku"]
  s.homepage = %q{http://heroku.com/}
  s.licenses = ["MIT"]
  s.post_install_message = %q{ !    The `heroku` gem has been deprecated and replaced with the Heroku Toolbelt.
 !    Download and install from: https://toolbelt.heroku.com
 !    For API access, see: https://github.com/heroku/heroku.rb
}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.7.2}
  s.summary = %q{Client library and CLI to deploy apps on Heroku.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<heroku-api>, ["~> 0.3.7"])
      s.add_runtime_dependency(%q<netrc>, ["~> 0.7.7"])
      s.add_runtime_dependency(%q<rest-client>, ["~> 1.6.1"])
      s.add_runtime_dependency(%q<launchy>, [">= 0.3.2"])
      s.add_runtime_dependency(%q<rubyzip>, [">= 0"])
    else
      s.add_dependency(%q<heroku-api>, ["~> 0.3.7"])
      s.add_dependency(%q<netrc>, ["~> 0.7.7"])
      s.add_dependency(%q<rest-client>, ["~> 1.6.1"])
      s.add_dependency(%q<launchy>, [">= 0.3.2"])
      s.add_dependency(%q<rubyzip>, [">= 0"])
    end
  else
    s.add_dependency(%q<heroku-api>, ["~> 0.3.7"])
    s.add_dependency(%q<netrc>, ["~> 0.7.7"])
    s.add_dependency(%q<rest-client>, ["~> 1.6.1"])
    s.add_dependency(%q<launchy>, [">= 0.3.2"])
    s.add_dependency(%q<rubyzip>, [">= 0"])
  end
end
