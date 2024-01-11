class SearchesController < ApplicationController
  before_action :set_user_ip, only: [:index]

  def home 
    @articles = Article.all
    @popular_searches = Search.group(:term).order('count_term DESC').limit(3).count(:term)
  end

  def index
    term = params[:term]
  
    if term.present?
      current_user.save
      current_user.searches.create(term: term)
    end
  
    @articles = if term.present?
                  Article.where('title ILIKE ?', "%#{term}%")
                else
                  Article.all
                end
  
    render 'articles/_index'
  end

  private

  def set_user_ip
    @user = User.find_or_initialize_by(ip: @user_ip)
    unless @user.persisted?
      @user.save
    end
  end
end
