#
# Cookbook Name:: chip-audio
# Recipe:: airplay
#
# Copyright (C) 2016 wschiffels@users.noreply.github.com
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#<> install additional packages
node['chip-audio']['airplay']['packages'].each do |p|
  package p
end

include_recipe 'chip-audio::_user'
include_recipe 'chip-audio::_compile'

#<> drop config
template '/etc/shairport-sync.conf' do
  source 'shairport-sync.conf.erb'
  owner 'root'
  group 'root'
  mode '0744'
end

#<> enable service
service 'shairport-sync' do
  supports :status => true, :restart => true, :reload => false
  action [:enable, :start]
end
