# frozen_string_literal: true

require 'test_helper'


class TestPull < Minitest::Test
  # backup files not needed when pulling. Youre pulling into a git managed repo
  def setup
    @logger = create_logger(__FILE__)
    @test_files = %w[vimrc pryrc zshrc].freeze
    @test_dirs = %w[config dir2].freeze
    @sshd_config = 'sshd_config'
    @gnome_terminal = 'gnome_terminal_settings'

    VpsCli.load_test_configuration
    @config = VpsCli.configuration
    @base_dirs = [@config.local_dir, @config.dotfiles, @config.misc_files, @config.config_files].freeze

    rm_dirs(@base_dirs)
    mk_dirs(@base_dirs)
  end

  def teardown
    VpsCli.reset_configuration
    rm_dirs(@base_dirs)
  end

  def create_local_and_remote_files
    # dotfiles
    add_files(@config.local_dir, @test_files)
    add_dirs(@config.local_dir, @test_dirs)

    add_files(@config.dotfiles, @test_files)
    add_dirs(@config.dotfiles, @test_dirs)

    # miscfiles
    add_files(@config.local_dir, @sshd_config)
    add_files(@config.local_dir, @gnome_terminal)

    add_files(@config.local_dir, @sshd_config)
    add_files(@config.local_dir, @gnome_terminal)
  end

  def write_to_file(file, string)
    File.open(file, 'w+') do
      puts string
    end
  end

  def test_create_local_and_remote_files
    assert_empty Dir.children(@config.local_dir)
    assert_empty Dir.children(@config.dotfiles)

    create_local_and_remote_files

    refute_empty Dir.children(@config.local_dir)
    refute_empty Dir.children(@config.dotfiles)
  end

  def test_pulls_dotfiles_properly
    create_local_and_remote_files

    log_methods(@logger) do
      VpsCli::Pull.dotfiles(@config)
    end
  end

  def test_pulls_gnome_terminal_properly
    skip
  end
end
