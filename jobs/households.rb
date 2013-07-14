require_relative '../lib/client'

SCHEDULER.every '15s', allow_overlapping: false do |job|
  households = Msm::Client.summary

  send_event('households-count', { current: households['households_total'] })
  
end