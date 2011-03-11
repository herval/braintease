class Solution < ActiveRecord::Base
  acts_as_voteable
  acts_as_commentable
end
