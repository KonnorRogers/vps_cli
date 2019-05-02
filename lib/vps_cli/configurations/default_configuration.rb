#!/usr/bin/env ruby

require 'vps_cli'

VpsCli.configure do |config|
  # Where items will be copied to
  # For example, the local dir is where you would your dotfiles
  # saved to
  config.local_dir = Dir.home
  config.backup_dir = File.join(Dir.home, 'backup_files')
  config.local_sshd_config = File.join(Dir.home, '.ssh', 'sshd_config')

  # You must set these values yourself

  # Location of your config files
  # config.config_files = File.join(Dir.home, 'config_files')
  config.config_files = nil

  # Location of your dotfiles
  # config.config_files = File.join(Dir.home, 'config_files', 'dotfiles')
  config.dotfiles = nil

  # Location of your dotfiles
  # config.config_files = File.join(Dir.home, 'config_files', 'dotfiles')
  config.misc_files = nil

  config.verbose = false

  # Change to false if you dont want to be prompted
  # about file creations / overwrites
  config.interactive = true

  # this is merely for testing purposes, dont worry about this
  config.testing = false
end

