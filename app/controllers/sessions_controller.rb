class SessionsController < ApplicationController
  # before_action :set_session, only: %i[ show edit update destroy ]

  # GET /sessions or /sessions.json
  def index
    @sessions = Session.all
  end

  # GET /sessions/1 or /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
    @session = Session.new
  end

  # GET /sessions/1/edit
  def edit
  end

  # POST /sessions or /sessions.json
  def create
    @user = User.find_by(name: params[:name])

    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_url(@user)
    else
      message = "Blocked like a flimsy baby running back against Julius Peppers"
      redirect_to login_path, notice: message
    end
  end

  # PATCH/PUT /sessions/1 or /sessions/1.json
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to session_url(@session), notice: "Session was successfully updated." }
        format.json { render :show, status: :ok, location: @session }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1 or /sessions/1.json
  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: "Logged out!"

    # @session.destroy!

    # respond_to do |format|
    #   format.html { redirect_to sessions_url, notice: "Session was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def session_params
      params.fetch(:session, {})
    end
end
