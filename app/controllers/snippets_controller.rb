class SnippetsController < ApplicationController
  include SnippetsHelper

  before_action :set_snippet, only: [:show, :edit, :update, :destroy, :execute]
  before_action :authenticate_user!, except: [:index, :show, :execute]

  # GET /snippets
  # GET /snippets.json
  def index
    @snippets = Snippet.all
  end

  # GET /snippets/1
  # GET /snippets/1.json
  def show
  end

  # GET /snippets/new
  def new
    @snippet = Snippet.new
  end

  # GET /snippets/1/edit
  def edit
  end

  # POST /snippets
  # POST /snippets.json
  def create
    @snippet = Snippet.new(snippet_params)

    respond_to do |format|
      if @snippet.save
        format.html { redirect_to snippets_url, notice: 'Snippet was successfully created.' }
        format.json { render :show, status: :created, location: @snippet }
      else
        format.html { render :new }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snippets/1
  # PATCH/PUT /snippets/1.json
  def update
    respond_to do |format|
      if @snippet.update(snippet_params)
        format.html { redirect_to snippets_url, notice: 'Snippet was successfully updated.' }
        format.json { render :show, status: :ok, location: @snippet }
      else
        format.html { render :edit }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snippets/1
  # DELETE /snippets/1.json
  def destroy
    @snippet.destroy
    respond_to do |format|
      format.html { redirect_to snippets_url, notice: 'Snippet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /snippets/execute
  def execute
    output = execute_snippet_content(@snippet.content)
    @snippet.execution_output = "#{output[:stdout].join('')}#{output[:stderr].join('')}"
    update_params = {'execution_output' => @snippet.execution_output}
  
    respond_to do |format|
      if output[:success] and @snippet.update(update_params)
        notice_message = 'Snippet content was successfully executed.'
        format.html { redirect_to @snippet, notice: notice_message }
        format.js { flash.now[:notice] = notice_message }
        format.json { render :show, status: :ok, location: @snippet }
      else
        alert_message = 'Snipped content execution failed!'
        format.html { redirect_to @snippet, alert: alert_message }
        format.json { render json: alert_message, status: :ok, location: @snippet }      
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snippet
      @snippet = Snippet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snippet_params
      params.require(:snippet).permit(:name, :content, :execution_output, :user_id)
    end
end
