class Post < ActiveRecord::Base
    attr_accessible :text, :title
    # make comment destroys dependent on post destroys
    has_many :comments, dependent: :destroy
    validates :title, presence: true,
                      length: { minimum: 5 }
end
