class DrugsController < ApplicationController
  def new
  end
  
  def search
    
  end
  
  def index
    @drugs = Drug.includes(:stores)
  end
  
  def show
    @drug = Drug.find_by(id: params[:id])
  end
  
  def print
    drugJson = JSON.parse(params[:drugList])
    
    @storeList = drugJson["stores"]
    @drugList = drugJson["drugs"]
  end
end
