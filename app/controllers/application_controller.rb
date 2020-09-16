class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :layout_home
  before_action :tagging_orders

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :profile, :image])
  end

  def layout_home
    @recent = Post.order('created_at DESC').first(10)
    @popular = User.all.sort { |a, b| b.impressionist_count <=> a.impressionist_count }
  end

  def tagging_orders
    @tags = ActsAsTaggableOn::Tag.all.sort { |a, b| b.taggings_count <=> a.taggings_count }
  end
end
