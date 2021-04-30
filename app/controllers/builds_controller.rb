class BuildsController < ApplicationController

  get '/builds' do
    authenticate
    @user = current_user
    @builds = Build.all
    erb :"store/builds"
  end

  get '/builds/new' do
    authenticate
    @build = Build.new
    erb :"/store/new_build"
  end

  post '/builds' do
    @build = Build.create(title: params[:title], description: params[:description], price: params[:price], user: current_user, image: params[:image])
      
    if @build.errors.any?
      erb :"/store/new_build"
    else
      erb :"store/show_build"
    end
  end

  get '/builds/:id' do  
    @failed = false
    authenticate
    @build = Build.find_by_id(params[:id])
    redirect '/builds' if @build.nil?
    #not_found if @item.nil?
    erb :"store/show_build"
  end

  get '/builds/:id/edit' do
    @build = Build.find_by(id: params[:id])
    authenticate

    if logged_in? && @build.user_id == current_user.id
      erb :"store/edit_build"
    else
      @failed = true
      erb :"store/show_build"
    end
  end

  patch '/builds/:id' do
    @build = Build.find_by(id: params[:id])
    # not_found if !@item
    @build.update(title: params[:title], description: params[:description], price: params[:price], image: params[:image])
            
    if @build.errors.any?
      erb :"/store/edit_build"
    else
      erb :"store/show_build"
    end
  end

  delete '/builds/:id' do
    item = Build.find_by_id(params[:id])
    item.delete if item.user_id == current_user.id
    
    redirect '/builds'
  end

  post '/builds/search' do
    @user = current_user
    @word = params[:search]
    @builds = Build.where("title LIKE ?", "%#{params[:search]}%")
    @search = true
    erb :'store/builds'
  end

end