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

# create user and group
group node['chip-audio']['airplay']['shairport']['group'] do
  action :create
end

user node['chip-audio']['airplay']['shairport']['user'] do
  comment 'Shairport User'
  gid node['chip-audio']['airplay']['shairport']['group']
  shell '/usr/sbin/nologin'
end

#<> install additional packages
node['chip-audio']['airplay']['packages'].each do |p|
  package p
end

# checkout from github
git '/tmp/shairport' do
  repository node['chip-audio']['airplay']['shairport']['url']
  revision 'master'
  action :sync
  notifies :run, 'execute[configure shairport]', :immediately
end

execute 'configure shairport' do
  creates '/tmp/shairport/config.status'
  cwd '/tmp/shairport'
  command 'autoreconf -i -f && \
           ./configure --with-alsa \
                       --with-avahi \
                       --with-ssl=openssl \
                       --with-metadata \
                       --with-soxr \
                       --with-systemd'
  action :nothing
  notifies :run, 'execute[compile shairport]', :immediately
end

execute 'compile shairport' do
  creates '/usr/local/bin/shairport-sync'
  cwd '/tmp/shairport'
  command 'make && make install'
  action :nothing
end

template '/etc/shairport-sync.conf' do
  source 'shairport-sync.conf.erb'
  owner 'root'
  group 'root'
  mode '0744'
end
