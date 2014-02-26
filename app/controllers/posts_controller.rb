class PostsController < ApplicationController

    # authenticate user for every action except index and show
    http_basic_authenticate_with name: 'jimmy', password: 'secret',
    except: [:index, :show]

    # /posts
    def index
        # [list of all posts]
        @posts = Post.all
    end

    # method does nothing; as long as views/posts/new.html.rb exists,
    # new post page will be displayed
    # /posts/new
    def new
        # prevents nil when checking @post.errors.any? in new.html.erb
        @post = Post.new
    end

    # form data from /posts/new gets sent here (/posts) via POST
    def create
        # displays post information in JSON format
        # render([current,] :text => params[:post].inspect )
#        render text: params[:post].inspect

        # get post form data from params as new Post
# Rails 4.0
#        @post = Post.new(params[:post].permit(:title, :text))
        @post = Post.new(params[:post])

        # save post in sqlite db; save returns false if invalid
        if @post.save
            # send GET request to post, conveying post id => posts#show
            redirect_to @post
        else # invalid form
            # same form => posts#new
            render 'new'
        end
    end

    # posts#show: saves form data to @post to be used in view post/show
    # not sure how it finds the data via params[:id]
    # /posts/:id  (redirect_to, link_to @post)
    def show
        @post = Post.find(params[:id])
    end

    # /posts/:id/edit
    def edit
        @post = Post.find(params[:id])
    end

    # form data from /posts/:id/edit gets sent here (/posts/:id) via PATCH
    def update
        # get current post form data
        @post = Post.find(params[:id])

        # update post with form data from post/:id/edit
# Rails 4.0
#        if @post.update(params[:post].permit(:title, :text))
        if @post.update_attributes(params[:post])
            redirect_to @post
        else
            # same form => posts#edit
            render 'edit'
        end
    end

    # link_to 'link_name', post, method: :delete goes here
    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        # back to posts#index
        redirect_to posts_path
    end

    # security measure in Rails 4.0
    # only allow us to accept :title and :text parameters from post hash
    private
        def post_params
            params.require(:post).permit(:title, :text)
        end
end
