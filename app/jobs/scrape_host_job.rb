class ScrapeHostJob < ApplicationJob
  queue_as :urgent

  def perform(host)
    host.refresh_host
  end
end
