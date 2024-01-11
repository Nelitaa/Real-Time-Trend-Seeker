class ArticlesController < ApplicationController
  before_action :set_user_ip, only: [:index]

  def index
    term = params[:term]

    if term.present?
      current_user.save
      current_user.searches.create(term: term)
      @articles = Article.search_full_text(term)
    else
      @articles = Article.all
    end

    if turbo_frame_request?
      render partial: 'articles', locals: { articles: @articles }
    else
      render :index
    end
  end

  private

  def set_user_ip
    @user = User.find_or_initialize_by(ip: request.remote_ip)
    @user.save unless @user.persisted?
  end
end
