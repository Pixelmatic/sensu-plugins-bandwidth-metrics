#! /usr/bin/env ruby
#  encoding: UTF-8
#
#   metrics-bandwidth-usage
#
# DESCRIPTION:
#   This plugins uses ifstat to collect bandwidth usage on eth0 interface.
#   Metrics are in KB/s.
#
# OUTPUT:
#   metric data
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#   gem: socket
#
# USAGE:
#  ./metrics-bandwidth-usage.rb
#
# LICENSE:
#   Copyright 2016 Pixelmatic, Inc <contact@pixelmatic.com>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'sensu-plugin/metric/cli'
require 'socket'

class BandwidthUsageMetrics < Sensu::Plugin::Metric::CLI::Graphite
  option :scheme,
         description: 'Metric naming scheme, text to prepend to .$parent.$child',
         long: '--scheme SCHEME',
         default: "#{Socket.gethostname}.bandwidth_usage"

  def run

    metrics = metrics_hash

    metrics.each do |k, v|
      output "#{config[:scheme]}.#{k}", v
    end

    ok
  end

  def metrics_hash
    metrics = {}
    i = 0
	
    `ifstat -i eth0 1 1`.each_line do |line|
       i += 1 
       next if i < 3
       metrics['download'] = line.strip.split(/\s+/)[0].to_f  
       metrics['upload'] = line.strip.split(/\s+/)[1].to_f 
    end

    metrics
  end

end
