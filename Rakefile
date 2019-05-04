# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test_task) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

task :import_pgp_key do
  puts "Importing sops_testing_keys.asc...\n\n"
  sh('gpg -q --import sops_testing_key.asc')
  puts ""
end

task test: %i[import_pgp_key test_task]

task default: :test
