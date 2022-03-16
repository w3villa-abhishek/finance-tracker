class StocksController < ApplicationController

  def search
      if !params[:ticker].nil?
            @stock = Stock.new_lookup(params[:ticker])
            if !@stock.nil?
            	respond_to do |format|
            		format.js{ render partial: 'users/result'}
            	end
            else
            	respond_to do |format|
            		flash.now.alert = "No stock is found with this symbol"
            		format.js{ render partial: 'users/result'}
            end
        end
      end
    end
end
