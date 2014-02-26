class CommentsController < ApplicationController

    # only authenticate user for destroy action
    http_basic_authenticate_with name: 'jimmy', password: 'secret',
    only: :destroy

    def index
    end

    def new
    end

    def create
        @post = Post.find(params[:post_id])
# Rails 4.0
# @comment = @post.comments.create(params[:comment].permit(:commenter, :body))
        # creates & saves comment
        @comment = @post.comments.create(params[:comment])
        redirect_to post_path(@post)
    end

    def show
    end

    def edit
    end

    def update
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
    end

end
