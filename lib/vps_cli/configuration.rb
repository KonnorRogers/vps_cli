# frozen_string_literal: true

module VpsCli
  # Used for keeping a consistent config across the entire project
  class Configuration
    # local files
    attr_accessor :local_dir, :backup_dir, :local_sshd_config
    attr_accessor :sshd_backup

    # configuration files to be used
    attr_accessor :config_files, :misc_files, :dotfiles, :yaml_file

    # used for displaying info
    attr_accessor :verbose, :interactive, :testing

    def initialize
      # Values for items to be copied to
      @local_dir = Dir.home
      @backup_dir = File.join(Dir.home, 'backup_files')
      @local_sshd_config = File.join(Dir.home, '.ssh', 'sshd_config')
      @sshd_backup = File.join(@backup_dir, 'sshd_config.orig')

      # values for items to be copied from
      # set to nil so that someone must set a path
      @config_files = nil
      @dotfiles = nil
      @misc_files = nil

      # Location of your SOPS encrypted yaml file
      @yaml_file = nil

      # used for displaying info
      @verbose = false
      @interactive = true
      @testing = false
    end
  end

  def self.configure
    @configuration ||= Configuration.new
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset_configuration
    @configuration = Configuration.new
  end

  def self.load_test_configuration
    test_config = File.join(File.expand_path(__dir__), 'configurations', 'testing_configuration.rb')
    load_configuration(test_config)
  end
  def self.load_configuration(file = File.join(Dir.home, '.vps_cli'))
    msg = 'Unable to location a configuration file. The default location is'
    msg += '$HOME/.vps_cli'
    msg += "\nTo create a standard default config, run 'vps-cli init'"

    raise Exception, msg unless File.exist?(file)

    load file
  end

  def self.create_configuration(file = File.join(Dir.home, '.vps_cli'))
    msg = "Creating a default configuration files @ $HOME/.vps_cli"
    msg += "\nPlease modify any values that are nil"

    puts msg
    default_config = File.join(File.expand_path(__dir__), 'default_configuration.rb')

    Rake.cp(default_config, file)
  end
end
