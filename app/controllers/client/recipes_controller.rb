class Client::RecipesController < ApplicationController
  def index
    response = HTTP.get("http://localhost:3000/api/recipes")
    @recipes = response.parse
    render 'index.html.erb'
  end

  def new
    render 'new.html.erb' #the new request is not sending anything to the backend..so the controller action is simple ..the new action is sending a request to the create action
  end

  def create
    client_params = {
                    title: params[:title],
                    prep_time: params[:prep_time],
                    ingredients: params[:ingredients],
                    directions: params[:directions],
                    image_url: params[:image_url]
                    }


    response = HTTP.post(
                        "http://localhost:3000/api/recipes", 
                        form: client_params
                        )
    #render "create.html.erb"
    recipe = response.parse
    redirect_to "/client/recipes/#{recipe["id"]}" #this makes a new webrequest using the show-get request in the routes file. that is the reason the show should come first, cause it can be confused with patch or delete, which have similar urls. 

  end

  def show
    response = HTTP.get("http://localhost:3000/api/recipes/#{params[:id]}")
    @recipe = response.parse
    # @recipe = Recipe.find(params[:id])
    render 'show.html.erb'
  end

  def edit
    response = HTTP.get("http://localhost:3000/api/recipes/#{params[:id]}")#this is important cause it will get the data to autopopulate the form fields in the edit form. without this, one is left guessing as to what the data is in the edit form field.
    # @recipe_id = params[:id] #the keyword of params only resides in the controller
    @recipe = response.parse #this is now making reference to the entire recipe
    render 'edit.html.erb'
  end

  def update
       client_params = {
                    title: params[:title],
                    prep_time: params[:prep_time],
                    ingredients: params[:ingredients],
                    directions: params[:directions],
                    image_url: params[:image_url]
                    }


    response = HTTP.patch(
                        "http://localhost:3000/api/recipes/#{params[:id]}", 
                        form: client_params
                        )
    #render 'update.html.erb'
    recipe = response.parse
    redirect_to "/client/recipes/#{recipe["id"]}"
  end

  def destroy
    response = HTTP.delete("http://localhost:3000/api/recipes/#{params[:id]}")
    redirect_to '/client/recipes' #these are the routes that you are being redirected to which will call the controller and then the show/index page
  end

end
