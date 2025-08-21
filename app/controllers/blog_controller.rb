class BlogController < ApplicationController
  def index
    @blog_posts = BlogPost.published.recent
  end
end
