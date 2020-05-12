class ListingsController < ApplicationController
    before_action :authenticate_user!

    def index
        @listings = Listing.all
    end

    def new
        @listing = Listing.new
    end

    def create
        @listing = current_user.listings.create(listing_params)
        if @listing.errors.any?
            render "new"
        else
            redirect_to listings_path
        end
    end

    def show
        @listing = Listing.find(params[:id])
    end

    private
    def listing_params
        params.require(:listing).permit(:title, :description, :price, :picture)
    end

end