class BlogController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :unpublished]
  before_action :ensure_admin!, only: [:new, :create, :unpublished]
  before_action :find_blog_post, only: [:show, :edit, :update]
  before_action :ensure_owner!, only: [:edit, :update]
  
  def index
    @blog_posts = BlogPost.published.recent
  end
  
  def unpublished
    @blog_posts = BlogPost.unpublished.recent.includes(:user)
  end
  
  def show
    # @blog_post is set by before_action :find_blog_post
    unless @blog_post&.published?
      # Allow unpublished posts to be viewed by their owner or admins
      unless user_signed_in? && (current_user == @blog_post.user || current_user.admin?)
        redirect_to blog_path, alert: 'Blog post not found.'
        return
      end
    end
  end
  
  def new
    @blog_post = current_user.blog_posts.build
  end
  
  def create
    @blog_post = current_user.blog_posts.build(blog_post_params)
    
    if @blog_post.save
      redirect_to blog_path, notice: 'Blog post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    # @blog_post is set by before_action :find_blog_post
  end
  
  def update
    if @blog_post.update(blog_post_params)
      redirect_to blog_post_path(@blog_post), notice: 'Blog post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  private
  
  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :published)
  end
  
  def find_blog_post
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to blog_path, alert: 'Blog post not found.'
  end
  
  def ensure_admin!
    redirect_to blog_path, alert: 'Access denied.' unless current_user.admin?
  end
  
  def ensure_owner!
    redirect_to blog_path, alert: 'Access denied.' unless @blog_post.user == current_user
  end
end
