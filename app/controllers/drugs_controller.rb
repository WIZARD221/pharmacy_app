class DrugsController < ApplicationController
  def new
  end
  
  def search
  end
  
  def index
    @drugs = Drug.includes(:stores).paginate(page: params[:page], per_page: 15).order('id ASC')
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
