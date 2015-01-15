require 'rubygems'
require 'nokogiri'
require './post.rb'
require './comment.rb'
require 'colorize'
require 'open-uri'



url = "https://news.ycombinator.com/item?id=8888485"
html_file = open(url)
doc = Nokogiri::HTML(html_file)

class Execute
  attr_reader :comments
  def initialize(doc)
    @title = doc.search('.subtext > span:first-child').map { |span| span.inner_text}
    @id= doc.search('.subtext > a:nth-child(3)').map {|link| link['href'] }
    @url = doc.search('.title > a:first-child').map { |link| link.inner_text}
    @points = doc.search('.title > a:first-child').map { |link| link['href']}
    @comments = doc.search('.comment > font:first-child').map { |font| font.inner_text}
    @poster= doc.search('.comhead > a:first-child').map { |link| link.inner_text}
  end

  def make_post
    Post.new(@title,@id,@url,@points, @poster)
  end

  def comment_object_create(poster,comments, post)
    for i in 0..(comments.length - 1)
      # binding.pry
      comment_object= Comment.new(poster[i],comments[i])
      post.add_comments(comment_object)
    end
  end

  def top_user(array_of_comments)
    count_hash = {}
    #input is an array of objects
    array_of_comments.each do |object| 
      count_hash[object.poster]=0 
    end

    array_of_comments.each do |object|  
        count_hash[object.poster] +=1 
    end

    count_hash.each { |k, v| return k if v == count_hash.values.max }

  end
end



execution = Execute.new(doc)

hacker_news = execution.make_post 

execution.comment_object_create(hacker_news.poster,execution.comments, hacker_news)

puts "NUMBER OF COMMENTS: #{hacker_news.comments.length}".red 
puts "TOP POSTER: #{execution.top_user(hacker_news.comments)}".red


puts " "

hacker_news.comments.each do |object| 
  puts "Username: #{object.poster}".green
  puts "-"*25
  puts "#{object.comment}".blue
  puts " "
  puts " "
end







