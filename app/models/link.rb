class Link < ActiveRecord::Base
  before_validation :validate_long_url 
  before_create :generate_short_url, :generate_admin_url

  private

  # create a unique short URL
  def generate_short_url
    random_chars = ['0'..'9','A'..'Z','a'..'z'].map{|range| range.to_a}.flatten
    self.assign_attributes(short_url: 6.times.map{ random_chars.sample }.join.prepend("http://")) until self.short_url.present? && Link.find_by_short_url(short_url).nil?
  end

  def generate_admin_url
    random_chars = ['0'..'9','A'..'Z','a'..'z'].map{|range| range.to_a}.flatten
    self.assign_attributes(admin_url: 6.times.map{ random_chars.sample }.join.prepend("http://")) until self.admin_url.present? && Link.find_by_admin_url(short_url).nil?
  end

  def validate_long_url
    if long_url.present? && !valid_url?(long_url)
      errors.add(:long_url, message: "URL is invalid")
      return false
    end
    true
  end

  def valid_url?(url)
    uri = URI.parse(url)
    uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end
end
