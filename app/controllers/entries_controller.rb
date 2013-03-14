class EntriesController < ApplicationController
  before_filter :find_small_entries

  # GET /entries
  # GET /entries.json
  def index
    if params[:easy_mode] == 'true'
      @entries = Entry.easy_game
    else
      @entries = Entry.game
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  # new route for submission
  def new
    #pull a new entry
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @entry = Entry.new(params[:entry])

    if @entry.save
      redirect_to(@entry)
    else
      render :new
    end
  end

  # PUT /entries/win
  def win
    # Store the last entries so we can display them below
    session[:last_win_id] = params[:win_id]
    session[:last_lose_id] = params[:lose_id]

    # Increment the win/lose counters
    Entry.find(params[:win_id]).increment!(:wins)
    Entry.find(params[:lose_id]).increment!(:losses)

    # Respond with an empty
    respond_to do |format|
      format.json { render json: {} }
    end
  end

  # PUT /entries/draw
  def draw
    Entry.find(params[:draw_ids][0]).increment!(:draws)
    Entry.find(params[:draw_ids][1]).increment!(:draws)
    respond_to do |format|
      format.json { render json: {} }
    end
  end

  private

  def find_small_entries
    if session[:last_win_id]
      @small_entries = {
        :last_win_id => Entry.find(session[:last_win_id]),
        :last_lose_id => Entry.find(session[:last_lose_id])
      }
    end
  end
end
