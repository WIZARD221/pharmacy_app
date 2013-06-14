class DrugsController < ApplicationController
  def new
  end
  
  def search
    
  end
  
  def index
    @drugs = Drug.all(:include => :stores)
  end
  
  def show
    @drug = Drug.find(params[:id])
  end
end
