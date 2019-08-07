# frozen_string_literal: true

require 'thor'
require 'open3'

module VpsCli
  # The CLI component of this library
  # Integrates Thor
  # @see http://whatisthor.com/
  class Cli < Thor
    # this is available as a flag for all methods
    class_option :config, aliases: :c, default: File.join(Dir.home, '.vps_cli')

    desc 'version', 'prints the vps-cli version information'
    def version
      puts "vps-cli version #{VpsCli::VERSION}"
    end
    map %w[-v --version] => :version

    desc 'fresh_install', 'accepts no arguments, my own personal command'
    def fresh_install
      VpsCli.load_configuration(options[:config])
      Copy.all
      Install.all_install

      Access.provide_credentials

      VpsCli.print_errors
    end

    desc 'init [-c (File)]', 'Creates a default vps_cli configuration file in the home directory'
    def init(file = options[:config])
      if File.exist?(file)
        loop do
          puts "#{file} already exists. Would you like to overwrite it? (Y/N)"
          input = $stdin.gets.chomp

          # breaks and creates the config
          break if input.to_sym == :y
          return if input.to_sym == :n

          # continue the loop otherwise
        end
      end
      VpsCli.create_configuration(file)
    end

    desc 'install_gems', 'runs gem install on all gems in packages.rb'
    def install_gems
      Packages::GEMS.each do |g|
        Rake.sh("gem install #{g}")
      end
    end

    desc 'copy [OPTIONS]', 'Copies files from <vps_cli/config_files>'
    def copy
      VpsCli.load_configuration(options[:config])
      Copy.all
    end

    desc 'pull [OPTIONS]', 'Pulls files into your vps_cli repo'
    options %i[dotfiles_dir misc_files_dir]
    def pull
      VpsCli.load_configuration(options[:config])
      Pull.all
    end

    desc 'update_all', 'updates all packages'
    def update_all
      VpsCli.load_configuration(options[:config])
      Install.prep
      Install.install_non_apt_packages
    end

    desc 'install_all', 'installs all packages'
    def install_all
      Install.all_install

      return if VpsCli.errors.empty?

      VpsCli.print_errors
    end

    desc 'login', 'pushes keys from your ~/.credentials.yaml file'
    def login
      VpsCli.load_configuration(options[:config])
      VpsCli.provide_credentials
    end

    desc 'git_pull', 'Automatically pulls in changes in your config_files repo'
    def git_pull
      swap_dir { Rake.sh('git pull') }
    end

    desc 'git_push [message]', 'Automatically pushes changes of your config_files'
    def git_push(message = nil)
      message ||= 'auto push files'

      swap_dir do
        Rake.sh('git add -A')
        Rake.sh("git commit -m \"#{message}\"")
        Rake.sh('git push')
      end
    end

    desc 'git_status', 'provides the status of your config_files'
    def git_status
      swap_dir { Rake.sh('git status') }
    end

    no_commands do
      def swap_dir
        VpsCli.load_configuration(options[:config])
        Rake.cd(VpsCli.configuration.config_files)
        yield
      end
    end
  end
end
