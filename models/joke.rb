# models/joke.rb

class Joke < ActiveRecord::Base
  belongs_to :user
  validates :content, presence: true
end
