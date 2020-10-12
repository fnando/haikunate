# frozen_string_literal: true

require_relative "lib/haikunate/version"

Gem::Specification.new do |spec|
  spec.name          = "haikunate"
  spec.version       = Haikunate::VERSION
  spec.authors       = ["Nando Vieira"]
  spec.email         = ["me@fnando.com"]
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.summary =
    "Generate Heroku-like memorable random names like adorable-ox-1234."
  spec.description = spec.summary
  spec.homepage      = "https://github.com/fnando/haikunate"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`
      .split("\x0")
      .reject {|f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-utils"
  spec.add_development_dependency "pry-meta"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-fnando"
end
