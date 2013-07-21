require_relative '../lib/client'

SCHEDULER.every '15s', allow_overlapping: false do |job|
  households = Msm::Client.household_summary

  send_event('households-count', { current: dashboard['household_summary'] })
  
end