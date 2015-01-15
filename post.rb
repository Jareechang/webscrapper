require 'pry'
require 'pry-nav'

class Post

  attr_accessor :comments, :poster
    
  def initialize(title,id,url,points, poster)
    @title = title
    @id = id
    @url = url
    @points = points
    @comments = []
    @poster = poster
  end

  def comments
    #returns all the comments
     @comments 
  end

 def add_comments(comment_object)
    @comments << comment_object
  end
end

# post = Post.new(title,id,url,points,comments)