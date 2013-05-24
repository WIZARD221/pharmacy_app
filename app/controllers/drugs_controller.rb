class DrugsController < ApplicationController
  def new
  end
  
  def search
    
  end
  
  def index
    @drugs = Drug.all
  end
end
