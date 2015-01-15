class Comment 
  attr_reader :comment, :poster
  def initialize(poster,comment)
    @comment = comment 
    @poster= poster
  end
end