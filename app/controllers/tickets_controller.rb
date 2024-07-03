class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]

  # GET /tickets or /tickets.json
  def index
    if current_user.id != nil && !current_user.admin
      @tickets = Ticket.where(user_id: current_user.id)
    elsif current_user.admin && params[:search].present?
      @tickets = Ticket.where(user_id: params[:search])
    else
      @tickets = Ticket.all
    end
  end

  # GET /tickets/1 or /tickets/1.json
  def show
    if current_user.id != @ticket.user_id && !current_user.admin
      redirect_to root_path
    end
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new

    # Added these lines so that the selected train’s data fields are available to the views at the front end
    if @train.nil?
      begin
        @train = Train.find(params[:train_id])
      rescue
        redirect_to root_path
      end
    end
  end

  # GET /tickets/1/edit
  def edit
    if current_user.id != @ticket.user_id && !current_user.admin
      redirect_to root_path
    end

    if @train.nil?
      @train = @ticket.train
    end
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    # Created the confirmation number using a random string of length 10
    @ticket.confirmation_number = SecureRandom.random_number(10**10).to_s.rjust(10,'0')
    @train = Train.find(params[:ticket][:train_id])

    @ticket.user_id = current_user.id


    # Linked the ticket to the user if not an admin
    # if !current_user.admin
    #   @ticket.user_id = current_user.id
    # end

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully created." }
        format.json { render :show, status: :created, location: @ticket }

        # Updating the train capacity
        if !@ticket.user.nil?
          @train.available_seats = @train.available_seats - 1
          @train.save
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    if @train.nil?
      @train = @ticket.train
    end

    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }

      # Updating the train capacity
      @train.available_seats = @train.available_seats + 1
      @train.save

    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ticket_params
    # if !current_user.admin?
    #   params.require(:ticket).permit(:quantity, :train_id)
    # else
    params.require(:ticket).permit(:train_id, :confirmation_number, :quantity)
    # end
  end
end
