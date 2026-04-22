# frozen_string_literal: true

require_relative "lib/poster/version"

Gem::Specification.new do |spec|
  spec.name = "poster"
  spec.version = Poster::VERSION
  spec.authors = ["komba"]
  spec.email = ["eugene@russkikh.org.ua"]

  spec.summary = "Ruby wrapper for Poster"
  spec.description = "PIAPOS"
  spec.homepage = "https://github.com/komba/poster"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/komba/poster"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency("faraday", "2.14.1")
end
