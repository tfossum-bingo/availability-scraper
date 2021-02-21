class Host < ApplicationRecord
  has_many :listings, dependent: :destroy

  after_create :initial_scrape


  private

  def initial_scrape
    ScrapeHostJob.perform_later(self)
  end

end
