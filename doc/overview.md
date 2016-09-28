Playing around with [C.H.I.P](https://getchip.com/), [Chef](https://www.chef.io/) and
[knife-solo](https://matschaffer.github.io/knife-solo/).

As for Airplay: It's copy & paste from [chip.hackster.io](https://chip.hackster.io/11798/c-h-i-p-play-speakers-7cebb9)


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
