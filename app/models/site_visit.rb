class SiteVisit < ApplicationRecord
  IP_REGEX = /([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}/

  belongs_to :site, class_name: 'Site', required: true, counter_cache: :visits_count

  validates :site, presence: true
  validates :ip_address, presence: true, format: { with: IP_REGEX }
end
