class MealsController < ApplicationController
  http_basic_authenticate_with name: Rails.application.credentials.dig(:basic_auth, :user), password: Rails.application.credentials.dig(:basic_auth, :pass)
  before_action :set_meal, only: %i[ show edit update destroy ]
  before_action :hash_meal, only: %i[ index stats ]

  # GET /meals or /meals.json
  def index
    @meal = Meal.new
    @day = []
  end

  def stats
  end
  # GET /meals/1 or /meals/1.json
  def show
  end

  # GET /meals/new
  def new
    @meal = Meal.new
  end

  # GET /meals/1/edit
  def edit

  end

  # POST /meals or /meals.json
  def create
    @meal = Meal.new(meal_params)
    @meal.fed_time = Time.now
    

    respond_to do |format|
      if @meal.save
        format.html { redirect_to root_url, notice: "Meal was successfully created." }
        format.json { render :show, status: :created, location: @meal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1 or /meals/1.json
  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to root_url, notice: "Meal was successfully updated." }
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1 or /meals/1.json
  def destroy
    @meal.destroy

    respond_to do |format|
      format.html { redirect_to meals_url, notice: "Meal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    def hash_meal
      @meals = Meal.all.sort
      @meal_hash = Hash.new
      @meals.each do |meal|
        @meal_hash[meal.created_at.strftime("%m/%d")] = [] unless @meal_hash.include?(meal.created_at.strftime("%m/%d"))
        @meal_hash[meal.created_at.strftime("%m/%d")] << [meal.food, meal.quantity]
      end
      @meal_hash.each do |date, val|
        hash = {
          'formula' => 0, 
          'bank' => 0,
          'breast' => 0,
          :total => 0 }
        val.each do |feed| 
          hash[feed[0]] += feed[1]
          hash[:total] += feed[1]
        end
  
        @meal_hash[date] = hash
      end
    end
    
    # Only allow a list of trusted parameters through.
    def meal_params
      params.require(:meal).permit(:quantity, :food, :fed_time)
    end
end
