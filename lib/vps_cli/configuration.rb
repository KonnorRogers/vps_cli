module VpsCli
  class Configuration
    # local files
    attr_accessor :local, :backup, :local_sshd_config

    # configuration files to be used
    attr_accessor :config_files, :misc_files, :dotfiles

    # used for displaying info
    attr_accessor :verbose, :interactive, :testing

    def initialize
      # Values for items to be copied to
      @local = Dir.home
      @backup = File.join(Dir.home, 'backup_files')
      @local_sshd_config = File.join(Dir.home, '.ssh', 'sshd_config')

      # values for items to be copied from
      # set to nil so that someone must set a path
      @config_files = nil
      @dotfiles = nil
      @misc_files = nil

      # used for displaying info
      @verbose = false
      @interactive = false
      @testing = false
    end
  end
end
