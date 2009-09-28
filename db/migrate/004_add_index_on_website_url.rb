class AddIndexOnWebsiteUrl < ActiveRecord::Migration
  def self.up
    rename_column :links, :website_url, :website_url_old
    add_column :links, :website_url, :string, :limit => 500
    Link.find_each(:batch_size => 500) do |link|
      link.website_url = link.website_url_old
      link.save
    end
    add_index :links, :website_url    
    remove_column :links, :website_url_old
  end

  def self.down
    remove_index :links, :website_url
    rename_column :links, :website_url, :website_url_old
    add_column :links, :website_url, :text
    Link.find_each(:batch_size => 100) do |link|
      link.website_url = link.website_url_old
      link.save
    end
    add_index :links, :website_url    
    remove_column :links, :website_url_old
  end
end
