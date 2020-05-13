class ListingsController < ApplicationController
    before_action :authenticate_user!

    def index
        @listings = Listing.all

        session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            customer_email: current_user.email,
            line_items: [{
                name: "Donate to the mArtketplace!",
                amount: 1000,
                currency: 'aud',
                quantity: 1,
            }],
            payment_intent_data: {
                metadata: {
                    user_id: current_user.id,
                }
            },
            success_url: "#{root_url}pages/donated?userId=#{current_user.id}",
            cancel_url: "#{root_url}"
        )
    
        @session_id = session.id

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

    def edit
        @listing = current_user.listings.find_by_id(params[:id])

        if @listing
            render("edit")
        else
            redirect_to listing_path
        end
    end

    def update
        @listing = current_user.listings.find_by_id(params[:id])

        if @listing 
            @listing.update(listing_params)
            if @listing.errors.any?
                render "edit"
            else
                redirect_to listing_path
            end
        else
            redirect_to listing_path
        end
    end

    def show
        @listing = Listing.find(params[:id])
    end

    def destroy
        @listing = current_user.listings.find_by_id(params[:id])

        if @listing
            @listing.destroy
        end
        redirect_to listings_path
    end

    private

    def listing_params
        params.require(:listing).permit(:title, :description, :price, :picture)
    end

end