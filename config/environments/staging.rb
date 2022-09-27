# Based on production
require Rails.root.join("config", "environments", "production")

Rails.application.configure do
  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter     = :resque
  config.active_job.queue_name_prefix = "nla_arclight_staging"

  # allow requests to
  config.hosts << "delong.nla.gov.au"
  config.hosts << "deshort.nla.gov.au"
  config.hosts << "archives-test.nla.gov.au"
end
