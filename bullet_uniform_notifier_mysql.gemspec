# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bullet_uniform_notifier_mysql/version'

Gem::Specification.new do |spec|
  spec.name          = "bullet_uniform_notifier_mysql"
  spec.version       = BulletUniformNotifierMysql::VERSION
  spec.authors       = ["Takatoshi Ono"]
  spec.email         = ["takatoshi.ono@gmail.com"]

  spec.summary       = %q{Bullet uniform_notifier for mysql}
  spec.description   = %q{Bullet uniform_notifier for mysql}
  spec.homepage      = "https://github.com/takatoshiono/bullet_uniform_notifier_mysql"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_development_dependency "bullet"
  spec.add_development_dependency "uniform_notifier"
  spec.add_development_dependency "mysql2"
end
