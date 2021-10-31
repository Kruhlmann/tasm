# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = "tasm"
  s.version = "0.0.1"
  s.date = "2021-10-30"
  s.summary = "x86 assembly transpiler"
  s.description = ""
  s.authors = ["Andreas Kruhlmann"]
  s.email = "andreas@kruhlmann.dev"
  s.files = ["lib/tasm/transpiler.rb"]
  s.homepage = "https://github.com/Kruhlmann/tasm"
  s.license = "GPL-3.0-or-later"
  s.required_ruby_version = "2.7"
  s.executables = ["tasm"]
end
