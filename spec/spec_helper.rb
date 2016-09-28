require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  # Specify the path for Chef Solo to find cookbooks
  # config.cookbook_path = '/var/cookbooks'

  # Specify the path for Chef Solo to find roles
  # config.role_path = '/var/roles'

  # Specify the Chef log_level (default: :warn)
  config.log_level = :error

  # Specify the path to a local JSON file with Ohai data
  # config.path = 'ohai.json'

  # Specify the operating platform to mock Ohai data from
  config.platform = 'centos'

  # Specify the operating version to mock Ohai data from
  config.version = '7.2.1511'

  # Use color output for RSpec
  config.color = true
  config.tty = true

  # Use documentation output formatter
  config.formatter = :documentation
end

at_exit { ChefSpec::Coverage.report! }
