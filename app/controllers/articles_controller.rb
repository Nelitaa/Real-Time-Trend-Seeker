# rubocop:disable all

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

    respond_to do |format|
      format.html do
        if turbo_frame_request?
          render partial: 'articles', locals: { articles: @articles, searches: @searches }
        else
          render :index
        end
      end

      format.turbo_stream do
        turbo_stream.append('articles', partial: 'articles', locals: { articles: @articles, searches: @searches })
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

    if term.present?
      entry = stack.find { |e| e[:complete_term] == term }
      if entry.present?
        entry[:count] ||= 0
        entry[:count] += 1
      else
        stack.push({ fragments: term.split, complete_term: term, timestamp: Time.now, count: 1 })
      end
    end

    stack.reject! do |entry|
      entry.nil? || entry[:timestamp].nil? || entry[:timestamp] < (Time.now - SEARCH_STACK_EXPIRY)
    end
    session[:search_stack] = stack
    @searches = stack.sort_by do |search_entry|
                  search_entry[:timestamp]
                end.reverse.map { |result_entry| { term: entry[:complete_term], count: result_entry[:count] } }
  end
end
# rubocop:enable all
