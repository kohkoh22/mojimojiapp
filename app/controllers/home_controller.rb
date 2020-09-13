class HomeController < ApplicationController
  def index
    @post = Post.order("created_at DESC").first(10)
  end
end
