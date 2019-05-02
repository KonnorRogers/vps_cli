require 'test_helper'

class TestConfiguration < Minitest::Test
  def setup
    @logger = create_logger(__FILE__)
  end

  def test_should_set_a_default_testing_configuration_with_no_nil_values
    refute VpsCli.configuration.instance_variables.any?(&:nil?)
  end

  def test_should_update_if_given_a_configure_block
    VpsCli.configure do |config|
      config.dotfiles = nil
    end

    p VpsCli.configuration
    is_nil =  VpsCli.configuration.instance_variables.any? do |var|
      var.nil?
    end

    p is_nil
  end
end
