#
# Cookbook Name:: chip-audio
# Recipe:: _compile
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

#<> checkout sources from github
git '/tmp/shairport' do
  repository node['chip-audio']['airplay']['shairport']['url']
  revision 'master'
  action :sync
  notifies :run, 'execute[configure shairport]', :immediately
  not_if { ::File.exist?('/usr/local/bin/shairport-sync') }
end

#<> configure for systemd
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

#<> compile & install
execute 'compile shairport' do
  creates '/usr/local/bin/shairport-sync'
  cwd '/tmp/shairport'
  command 'make && make install'
  action :nothing
end
