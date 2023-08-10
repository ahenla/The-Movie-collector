class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :comment, length: { minimum: 6 }
  validates :movie_id, uniqueness: {
    scope: :list_id,
    message: 'This movie is already in the list'
  }
end

# validates :guest_id, uniqueness: {
#   scope: [ :restaurant_id, :reservation_date ],
#   message: "Only one reservation per guest per day is permitted"
# }
