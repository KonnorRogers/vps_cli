module VpsCli
  class Configuration
    attr_accessor :local, :backup, :local_sshd_config,

      :verbose, :interactive, :testing

    def initialize
      # Values for items to be copied to
      @local = Dir.home
      @backup = File.join(Dir.home, 'backup_files')
      @local_sshd_config = File.join(Dir.home, '.ssh', 'sshd_config')

      # values for items to be copied from
    end
  end
end
