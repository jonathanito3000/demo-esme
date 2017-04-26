class Attachment < ApplicationRecord
  belongs_to :post
  include Picturable
end
