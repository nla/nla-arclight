# Based on production
require_relative "production"

Rails.application.configure do
  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter     = :resque
  config.active_job.queue_name_prefix = "nla_arclight_staging"

  # allow requests to
  config.hosts << "deshort.nla.gov.au"
  config.hosts << "catalogue-test.nla.gov.au"
end
