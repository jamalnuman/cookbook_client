class Client::RecipesController < ApplicationController
  def index
    response = HTTP.get("http://localhost:3000/api/recipes")
    @recipes = response.parse
    render 'index.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    client_params = {
                    title: params[:title],
                    prep_time: params[:prep_time],
                    ingredients: params[:ingredients],
                    directions: params[:directions],
                    image_url: params[:image_url]
                    }


    repsonse = HTTP.post(
                        "http://localhost:3000/api/recipes", 
                        form: client_params
                        )
    render "create.html.erb"

  end

  def show
    response = HTTP.get("http://localhost:3000/api/recipes/#{params[:id]}")
    @recipe = response.parse
    # @recipe = Recipe.find(params[:id])
    render 'show.html.erb'
  end




end
