class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    if params[:new_owner] != ""
      @owner = Owner.create(name: params[:new_owner])
    else
      @owner = Owner.find(params[:owners][:id])
    end
    if params[:pet][:name] != ""
      @pet = Pet.create(name: params[:pet][:name])
      @owner.pets << @pet
      @owner.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owner = @pet.owner
    @owners = Owner.all
    erb :'/pets/edit'
  end
  
  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name])
    if params[:new_owner] != ""
      @owner = Owner.create(name: params[:new_owner])
      @pet.update(owner_id: @owner.id)
    else
      @owner = Owner.find(params[:owner][:name])
      @pet.update(owner_id: @owner.id)
    end
    redirect to "pets/#{@pet.id}"
  end
end