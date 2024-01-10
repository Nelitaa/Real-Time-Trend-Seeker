class SearchesController < ApplicationController
  def home
    @articles = Article.all
  end
end
