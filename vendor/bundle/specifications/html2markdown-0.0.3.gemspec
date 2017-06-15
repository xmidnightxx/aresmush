# -*- encoding: utf-8 -*-
# stub: html2markdown 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "html2markdown"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["mike lee"]
  s.date = "2012-03-28"
  s.description = "simple and flexible html to markdown converter"
  s.email = ["mike.d.1984@gmail.com"]
  s.homepage = "https://github.com/29decibel/html2markdown"
  s.rubygems_version = "2.4.6"
  s.summary = "simple and flexible html to markdown converter"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end
