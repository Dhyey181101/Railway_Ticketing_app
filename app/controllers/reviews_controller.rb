class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    if params[:show_only_user_reviews] == "true" && params[:user_id].present?
      # Display reviews for the specified user if user_id is provided
      @reviews = Review.where(user_id: params[:user_id])
    else
      # Display all reviews or reviews based on your requirements
      @reviews = Review.all
    end
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
    unless current_user == @review.user
      flash[:alert] = "You can only edit your own reviews."
      redirect_to root_path
    end
  end

  # POST /reviews or /reviews.json
  # app/controllers/reviews_controller.rb

def create
  @review = Review.new(review_params)

  # Find the train with the matching train_number
  train = Train.find_by(train_number: params[:review][:train_id])

  if train.nil?
    @review.errors.add(:train_id, 'No matching train found')
    render :new
    return
  end

  # Check if the current user has a ticket for this train
  unless current_user.tickets.exists?(train_id: train.id)
    @review.errors.add(:base, 'You can only create a review for a train you have a ticket for.')
    render :new
    return
  end

  @review.train_id = train.id

  respond_to do |format|
    if @review.save
      format.html { redirect_to review_url(@review), notice: "Review was successfully created." }
      format.json { render :show, status: :created, location: @review }
    else
      Rails.logger.error(@review.errors.full_messages.join(", "))
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @review.errors, status: :unprocessable_entity }
    end
  end
end


  def search
    search_query = params[:search_query]
    @reviews = Review.joins(:user, :train)
                     .where("users.name LIKE ? OR trains.train_number LIKE ?", "%#{search_query}%", "%#{search_query}%")
    # Render the search results template
    render 'search'
  end
  

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    @review = Review.find(params[:id])
    
    # Check if the current user is the owner of the review
    unless current_user == @review.user
      flash[:alert] = "You can only edit your own reviews."
      redirect_to root_path
      return # Ensure the code below doesn't get executed
    end
  
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review = Review.find(params[:id])
    
    # Check if the current user is the owner of the review
    unless current_user == @review.user
      flash[:alert] = "You can only delete your own reviews."
      redirect_to root_path
      return # Ensure the code below doesn't get executed
    end
  
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:user_id, :train_id, :rating, :feedback)
    end
end
