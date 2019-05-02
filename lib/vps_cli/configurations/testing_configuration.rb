#!/usr/bin/env ruby

require 'vps_cli'

test_dir = File.expand_path('../../../test', __dir__)

VpsCli.configure do |config|
  config.local_dir = File.join(test_dir, 'local_dir')
  config.backup_dir = File.join(test_dir, 'backup_dir')
  config.local_sshd_config = File.join(config.local_dir, 'sshd_config')

  config.config_files = File.join(test_dir, 'config_files')
  config.misc_files = File.join(config.config_files, 'miscfiles')
  config.dotfiles = File.join(config.config_files, 'dotfiles')

  config.verbose = true
  config.interactive = false
  config.testing = false
end

