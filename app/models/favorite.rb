class Favorite < ApplicationRecord

    belongs_to :user
#１人のユーザーが複数のいいねを行える為、belongs_to :userとなる
    belongs_to :book
#１つの投稿（book）に対して複数のいいねができるから、belongs_to :bookとなる
end
