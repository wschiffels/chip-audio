# Description

Playing around with [C.H.I.P](https://getchip.com/), [Chef](https://www.chef.io/) and
[knife-solo](https://matschaffer.github.io/knife-solo/).

As for Airplay: It's copy & paste from https://chip.hackster.io/11798/c-h-i-p-play-speakers-7cebb9


```bash
# prepare the chip (Headless 4.4 http://flash.getchip.com/)
root@chip:~# apt-get install build-essential \
             ruby \
             ruby-dev \
             libssl-dev \
             rsync

# (work around ERROR:  Error installing passenger:
#         rack requires Ruby version >= 2.2.2.)
root@chip:~# gem install rubygems-update
root@chip:~# update_rubygems

# on workstation
ws: ~ $ gem install knife-solo
ws: ~ $ mkdir chefrepo
ws: ~ $ cd chefrepo
ws: ~ $ knife solo init .
ws: ~ $ knife solo prepare root@<chip ip>
# copy cookbook(s) to ./site-cookbooks
# edit runlist in nodes/<chip ip>.json
```

```json
{
  "run_list": [
    "chip-audio::airplay"
  ],
  "automatic": {
    "ipaddress": "10.10.10.10"
  }
}
```


```bash
ws: ~ $ knife solo cook root@<chip ip>
```

# Requirements

## Platform:

* debian

## Cookbooks:

*No dependencies defined*

# Attributes

* `node['chip-audio']['airplay']['packages']` -  Defaults to `%w(`.
* `node['chip-audio']['airplay']['shairport']['url']` -  Defaults to `https://github.com/mikebrady/shairport-sync`.
* `node['chip-audio']['airplay']['shairport']['user']` -  Defaults to `shairport`.
* `node['chip-audio']['airplay']['shairport']['group']` -  Defaults to `shairport`.
* `node['chip-audio']['airplay']['interpolation']` -  Defaults to `soxr`.
* `node['chip-audio']['airplay']['output_device']` -  Defaults to `hw:0`.

# Recipes

* [chip-audio::airplay](#chip-audioairplay) - Installs/configures airplay for chip

## chip-audio::airplay

install additional packages

# License and Maintainer

Maintainer:: wschiffels@users.noreply.github.com

Copyright:: 2016 wschiffels@users.noreply.github.com

License:: Apache 2.0

Licensed under the Apache License, Version 2.0 (the 'License'); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an 'AS IS' BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
