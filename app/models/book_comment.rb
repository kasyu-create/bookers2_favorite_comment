class BookComment < ApplicationRecord
  belongs_to :user
  #１人のユーザーが複数のコメントを行える為、belongs_to :userとなる
  belongs_to :book
  #１つの投稿（book）に対して複数のコメントができるから、belongs_to :bookとなる
  validates :comment, presence: true
  
end
