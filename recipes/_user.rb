#
# Cookbook Name:: chip-audio
# Recipe:: user
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

# create user and group
group node['chip-audio']['airplay']['shairport']['group'] do
  action :create
end

user node['chip-audio']['airplay']['shairport']['user'] do
  comment 'Shairport User'
  gid node['chip-audio']['airplay']['shairport']['group']
  shell '/usr/sbin/nologin'
end

# add user to audio
group 'audio' do
  action :modify
  members node['chip-audio']['airplay']['shairport']['user']
  append true
end
