class Ad < ActiveRecord::Base
  attr_accessible :category, :client, :image_path, :url, :style

  # Display VE ads for everyone
  def self.show_ads?(current_user)
    true
  end

  def self.ve_sample(style)
    where(:style => style, :client => "ve", :category => "b2c_ab").sample
  end

  # Samples a random ve banner ad
  def self.ve_banner
    ve_sample(style: 'banner')
  end

  # Samples a random ve box ad
  def self.ve_box
    ve_sample(style: 'box')
  end

end
