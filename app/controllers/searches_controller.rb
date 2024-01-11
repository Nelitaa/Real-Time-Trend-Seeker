class SearchesController < ApplicationController
  def home 
    @articles = Article.all
  end

  def index
    @articles = if params[:term].present?
                  Article.where('title ILIKE ?', "%#{params[:term]}%")
                else
                  Article.all
                end
    render 'articles/_index'
  end
end
