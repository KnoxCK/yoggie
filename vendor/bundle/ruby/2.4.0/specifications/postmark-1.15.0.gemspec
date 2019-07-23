# -*- encoding: utf-8 -*-
# stub: postmark 1.15.0 ruby lib

Gem::Specification.new do |s|
  s.name = "postmark".freeze
  s.version = "1.15.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.7".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Petyo Ivanov".freeze, "Ilya Sabanin".freeze, "Artem Chistyakov".freeze]
  s.date = "2019-01-09"
  s.description = "Use this gem to send emails through Postmark HTTP API and retrieve info about bounces.".freeze
  s.email = "ilya@wildbit.com".freeze
  s.extra_rdoc_files = ["LICENSE".freeze, "README.md".freeze]
  s.files = ["LICENSE".freeze, "README.md".freeze]
  s.homepage = "http://postmarkapp.com".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "\n    ==================\n    Thanks for installing the postmark gem. If you don't have an account, please\n    sign up at http://postmarkapp.com/.\n\n    Review the README.md for implementation details and examples.\n    ==================\n  ".freeze
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubygems_version = "2.6.11".freeze
  s.summary = "Official Postmark API wrapper.".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>.freeze, [">= 0"])
      s.add_development_dependency(%q<mail>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<json>.freeze, [">= 0"])
      s.add_dependency(%q<mail>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<json>.freeze, [">= 0"])
    s.add_dependency(%q<mail>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
