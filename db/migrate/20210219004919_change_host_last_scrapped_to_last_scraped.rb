class ChangeHostLastScrappedToLastScraped < ActiveRecord::Migration[6.0]
  def change
    rename_column :hosts, :last_scrapped, :last_scraped
  end
end
