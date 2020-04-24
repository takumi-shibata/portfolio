class PostsController < ApplicationController
	def new
	  @post = Post.new
	  @user = current_user
	end

	def index
	  @posts = Post.page(params[:page]).reverse_order
	  @user = current_user
	  @all_ranks = Post.find(Favorite.group(:post_id).order(Arel.sql('count(post_id) desc')).limit(3).pluck(:post_id))
	  #order/pluckの引数にSQL文字列を渡すと警告がでる→DEPRECATION WARNING
	  #コンソールの警告の文末の通り、SQL文字列.orderの後にArel.sql()で対策
	end

	def show
	  @post = Post.find(params[:id])
	  @user = @post.user
	  @post_comment = PostComment.new
	end

	def edit
	  @post = Post.find(params[:id])
	end

	def create
	  @post = Post.new(post_params)
	  @post.user_id = current_user.id
	  @post.save
	  redirect_to posts_path
    end

    def update
      @post = Post.find(params[:id])
      @post.update(post_params)
      redirect_to post_path
    end

    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to posts_path
    end

    private
    def post_params
        params.require(:post).permit(:title, :subtitle, :region, :area, :body,
        	:image)
    end
end