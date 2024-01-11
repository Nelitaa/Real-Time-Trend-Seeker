class ArticlesController < ApplicationController
  before_action :set_user_ip, only: [:index]

  def index
    term = params[:term]

    if term.present?
      current_user.save
      current_user.searches.create(term: term)
    end

    @articles = if term.present?
      Article.select('*')
      .select(Arel.sql("CASE WHEN title ILIKE #{ActiveRecord::Base.connection.quote("%#{term}%")} THEN 0 ELSE 1 END AS title_priority"))
      .where('title ILIKE ? OR content ILIKE ?', "%#{term}%", "%#{term}%")
      .order('title_priority, title')
                else
                  Article.all
                end

    @popular_searches = Search.group(:term).order('count_term DESC').limit(3).count(:term)

    render 'index'
  end

  private

  def set_user_ip
    @user = User.find_or_initialize_by(ip: request.remote_ip)
    @user.save unless @user.persisted?
  end
end
