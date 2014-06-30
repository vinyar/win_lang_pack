# 
# Integration Tests for Windows 
# Cookbook Name:: lang_pack
# File:: Rakefile
#
require 'rake'
require 'rspec/core/rake_task'

desc "Integration Tests for Windows"

RSpec::Core::RakeTask.new(:integration) do |t|
  t.pattern 	= 'test/integration/windows/spec/*/*_spec.rb'
  t.rspec_opts 	= '-I ./test/integration/windows/spec --color -f d'
end
