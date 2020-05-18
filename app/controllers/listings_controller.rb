class ListingsController < ApplicationController
    before_action :authenticate_user!
    before_action :get_users_listings, only: [:edit, :update, :destroy]

    def index
        @listings = Listing.all
        generate_stripe_session
    end

    def new
        @listing = Listing.new
    end

    def create
        @listing = current_user.listings.create(listing_params)
        rerender_if_error("new")
    end

    def edit
        if @listing
            render("edit")
        else
            redirect_to listing_path
        end
    end

    def update
        if @listing 
            @listing.update(listing_params)
            rerender_if_error("edit")
        else
            redirect_to listing_path
        end
    end

    def show
        @listing = Listing.find(params[:id])
    end

    def destroy
        if @listing
            @listing.destroy
        end
        redirect_to listings_path
    end

    private

    def get_users_listings
        @listing = current_user.listings.find_by_id(params[:id])
    end

    def listing_params
        params.require(:listing).permit(:title, :description, :price, :picture)
    end

    def generate_stripe_session
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

    def rerender_if_error(template_name)
        if @listing.errors.any?
            render template_name
        else
            redirect_to @listing
        end 
    end

end