class Video < ApplicationRecord
  validates :src, presence: true, format: { with: URI.regexp, message: "only allows url" }
end
