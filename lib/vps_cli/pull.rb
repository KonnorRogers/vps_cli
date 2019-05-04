# frozen_string_literal: true

require 'rake'
require 'vps_cli/helpers/file_helper'

module VpsCli
  # Pull changes from local dir into config dir
  # to be able to push changes up to the config dir
  class Pull
    # Base pull method
    # @param config [VpsCli::Configuration] The configuration to use
    # @see VpsCli::Configuration
    def self.all(config = VpsCli.configuration)
      # pulls dotfiles into specified directory
      dotfiles(config)

      # pulls from config.local_sshd_config
      sshd_config(config)

      # pulls via dconf
      gnome_terminal_settings(config)
    end


    # Pulls dotfiles from config.local into your
    #   specified config.dotfiles location
    def self.dotfiles(config = VpsCli.configuration)

      common_dotfiles(config.dotfiles,
                      config.local_dir) do |remote_file, local_file|
        copy_file_or_dir(local_file, remote_file)
      end
    end

    # Puts you at the point of a directory where the
    # local file and dotfile are the same allowing you to
    # copy them
    def self.common_dotfiles(dotfiles_dir, local_dir)
      Dir.each_child(dotfiles_dir) do |remote_file|
        Dir.each_child(local_dir) do |local_file|
          next unless local_file == ".#{remote_file}"

          remote_file = File.join(dotfiles_dir, remote_file)
          local_file = File.join(local_dir, local_file)
          yield(remote_file, local_file)
        end
      end
    end

    # Differentiates between files and dirs to appropriately copy them
    # Uses Rake.cp_r for directories, uses Rake.cp for simple files
    # @param orig_file [File, Dir] File or Dir you're copying from
    # @param new_file [File, Dir] File or Dir you're copying to
    # @param verbose [Boolean]
    def self.copy_file_or_dir(orig_file, new_file)
      if File.directory?(orig_file) && File.directory?(new_file)
        # Rake.cp_r(orig_file, new_file)
        Dir.each_child(orig_file) do |o_file|
          Dir.each_child(new_file) do |n_file|
            next unless o_file == n_file


            o_file = File.join(File.expand_path(orig_file), o_file)
            n_file = File.expand_path(new_file)

            Rake.cp_r(o_file, n_file)
          end
        end
      else
        Rake.cp(orig_file, new_file)
      end
    end

    # Pulls sshd_config from config.local_sshd_config into config.misc_files
    def self.sshd_config(config = Configuration.new)
      local = config.local_sshd_config
      remote = config.misc_files

      copy_file_or_dir(local, remote)
    end

    # Pulls the local config of gnome into the given config.misc_files
    def self.gnome_terminal_settings(config = VpsCli.configuration)
      # This is where dconf stores gnome terminal
      gnome_dconf = '/org/gnome/terminal/'
      remote_settings = File.join(config.misc_files,
                                  'gnome_terminal_settings')

      orig_remote_contents = File.read(remote_settings)

      Rake.sh("dconf dump #{gnome_dconf} > #{remote_settings}")
    rescue RuntimeError => error
      VpsCli.errors << error
      # if dconf errors, it will erase the config file contents
      # So this protects against that
      reset_to_original(remote_settings, orig_remote_contents)
    else
      puts "Successfully dumped Gnome into #{remote_settings}" if config.verbose
    end

    # Method intended for dealing with the way dconf will automatically
    # rewrite a file and make it empty
    # @param remote_settings [File] File located in your repo
    # @param orig_remote_contents [String] The String to be written to
    # remote settings
    def self.reset_to_original(remote_settings, orig_remote_contents)
      File.write(remote_settings, orig_remote_contents)
    end
  end
end
