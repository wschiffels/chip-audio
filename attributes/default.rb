#
# Cookbook Name:: chip-audio
# Attributes:: default
#
# Copyright (C) YEAR YOUR_NAME <YOUR_EMAIL>
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

default['chip-audio']['airplay']['packages'] = %w(
  avahi-daemon
  git
  autoconf
  libtool
  libdaemon-dev
  libasound2-dev
  libpopt-dev
  libconfig-dev
  libavahi-client-dev
  libssl-dev
  libsoxr-dev
)

default['chip-audio']['airplay']['shairport']['url'] = 'https://github.com/mikebrady/shairport-sync'
default['chip-audio']['airplay']['shairport']['user'] = 'shairport'
default['chip-audio']['airplay']['shairport']['group'] = 'shairport'
default['chip-audio']['airplay']['interpolation'] = 'soxr'
default['chip-audio']['airplay']['output_device'] = 'hw:0'
