class PagesController < ApplicationController
    def home
        generate_stripe_session
    end

    def donated
        generate_stripe_session
    end

    private

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
end