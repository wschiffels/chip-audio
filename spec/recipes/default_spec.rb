require_relative '../spec_helper'

# Write unit tests with ChefSpec - https://docs.chef.io/chefspec.html
describe 'skeleton::default' do
  platforms = {
    'centos' => %w(
      7.2.1511
    )
  }
  platforms.each do |platform, versions|
    versions.each do |version|
      describe "Plaform: #{platform}, version: #{version}" do
        cached(:chef_run) { ChefSpec::SoloRunner.new(platform: platform, version: version).converge(described_recipe) }

        it 'does something' do
          raise 'Replace this with meaningful tests'
        end
      end
    end
  end
end
