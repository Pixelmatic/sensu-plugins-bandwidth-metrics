# sensu-plugins-bandwidth-metrics

[Sensu](https://sensuapp.org/,"Sensu") plugin to get metrics on the bandwidth usage. It is reading the output of [ifstat](http://gael.roualland.free.fr/ifstat/, "ifstat"). 
`apt-get install ifstat` or `yum install ifstat`

Please be sure you have the right version of ifstat with the output formatted like this:
```
           eth0  
     KB/s in  KB/s out  
       40.09     81.06  
       38.23     62.96  
       ...
```

Put that script into the folder /etc/sensu/plugins/ or any folder registered in the PATH.

To add it into your checks/metrics configuration add that JSON:
```json
    "metric_bandwidth": {
      "type": "metric",
      "command": "metrics-bandwidth-usage.rb",
      "handlers": [ "metrics" ],
      "interval": 60,
      "subscribers": [
        "subscribers"
      ]
    }
```    

Tested on Sensu 0.22.1