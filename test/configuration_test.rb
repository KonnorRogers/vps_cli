require 'test_helper'

class TestConfiguration < Minitest::Test
  def setup
    @logger = create_logger(__FILE__)
    VpsCli.load_test_configuration
  end

  def teardown
    VpsCli.reset_configuration
  end

  def test_should_set_a_default_testing_configuration_with_no_nil_values
    any_nil = VpsCli.configuration.instance_variables.any? do |var|
      VpsCli.configuration.instance_variable_get(var).nil?
    end

    # no values should be nil
    refute any_nil
  end

  def test_should_update_if_given_a_configure_block
    VpsCli.configure do |config|
      config.dotfiles = nil
    end

    any_nil = VpsCli.configuration.instance_variables.any? do |var|
      VpsCli.configuration.instance_variable_get(var).nil?
    end

    # dotfiles should be nil therefore the values have not been set properly
    assert any_nil

    VpsCli.configure do |config|
      config.dotfiles = :test_dotfiles
    end

    assert_equal VpsCli.configuration.dotfiles, :test_dotfiles
  end
end
