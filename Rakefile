require "bundler/gem_tasks"
require 'rake'
require 'rake/testtask'
require './lib/xmodem/version.rb'

Rake::TestTask.new(:test) do |test|
	test.libs << 'lib' << 'test'
	test.pattern = 'test/**/test_*.rb'
	test.verbose = true
end

begin
	require 'rcov/task'
	Rcov::RcovTask.new do |test|
		test.libs << 'test'
		test.pattern = 'test/**/test_*.rb'
		test.verbose = true
	end
rescue LoadError
	task :rcov do
		abort 'RCov is not available. In order to run rcov, you must: gem install rcov'
	end
end

task :default => :test

namespace :docker do
	desc "Build docker"
	task :build do
		Dir.chdir(__dir__.to_s) do
			system "docker build --target development -t xmodem:1.0-dev -f Dockerfile ./"
		end
	end

	desc "Run docker"
	task :run do
		Dir.chdir(__dir__.to_s) do
			exec "docker run --init -it --rm xmodem:1.0-dev"
		end
	end

	desc "Run tests"
	task :test do
		Dir.chdir(__dir__.to_s) do
			system "docker build --target testing -t xmodem:1.0-test -f Dockerfile ./"
		end
	end
end



