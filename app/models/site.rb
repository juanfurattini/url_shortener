class Site < ApplicationRecord
  URL_REGEX = /(^$)|(^((http|https|ftp|file):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

  validates :url, presence: true, format: { with: URL_REGEX }

  before_validation :normalize_url

  after_save :generate_shorten_url

  private

  def normalize_url
    url.strip!
  end

  def generate_shorten_url
    self.shorten_url = ::UniqueIdentifierGenerator.generate_for_id(id: id)
  end
end
