class Link < ActiveRecord::Base
  before_create :generate_short_url, :generate_admin_url

  private

  # create a unique short URL
  def generate_short_url
    random_chars = ['0'..'9','A'..'Z','a'..'z'].map{|range| range.to_a}.flatten
    self.assign_attributes(short_url: 6.times.map{ random_chars.sample }.join) until self.short_url.present? && Link.find_by_short_url(short_url).nil?
  end

  def generate_admin_url
    random_chars = ['0'..'9','A'..'Z','a'..'z'].map{|range| range.to_a}.flatten
    self.assign_attributes(admin_url: 6.times.map{ random_chars.sample }.join) until self.admin_url.present? && Link.find_by_admin_url(short_url).nil?
  end
end
