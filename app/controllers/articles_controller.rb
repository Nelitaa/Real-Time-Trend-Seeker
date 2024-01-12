class ArticlesController < ApplicationController
  before_action :set_user_ip, only: [:index]
  before_action :initialize_search_stack, only: [:index]
  before_action :update_search_stack, only: [:index]

  SEARCH_STACK_EXPIRY = 20.seconds

  def index
    term = params[:term]

    if term.present?
      current_user.save
      @articles = Article.search_full_text(term)
    else
      @articles = Article.all
    end

    @searches = session[:search_stack].last[:complete_term] if session[:search_stack].present?

    respond_to do |format|
      format.html do
        if turbo_frame_request?
          render partial: 'articles', locals: { articles: @articles, searches: session[:search_stack] }
        else
          render :index
        end
      end

      format.turbo_stream do
        turbo_stream.replace('last-search-term', partial: 'last_search_term', locals: { term: term })
        turbo_stream.append('articles', partial: 'articles', locals: { articles: @articles, searches: session[:search_stack] })
      end
    end
  end

  private

  def set_user_ip
    @user = User.find_or_initialize_by(ip: request.remote_ip)
    @user.save unless @user.persisted?
  end

  def initialize_search_stack
    session[:search_stack] ||= []
  end

  def update_search_stack
    term = params[:term]
    stack = session[:search_stack]

    entry = stack.find { |e| e && e[:complete_term] == term }

    if entry.present?
      entry[:count] ||= 0
      entry[:count] += 1
    else
      stack.push({ fragments: term.split, complete_term: term, timestamp: Time.now, count: 1 }) if term.present?
    end

    stack.reject! { |entry| entry.nil? || entry[:timestamp].nil? || entry[:timestamp] < (Time.now - SEARCH_STACK_EXPIRY) }

    session[:search_stack] = stack
  end
end
