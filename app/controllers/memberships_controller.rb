class MembershipsController  < ApplicationController
       before_filter :ensure_that_signed_in, :except => [:index, :show]

       def new
          @beer_clubs = BeerClub.all
          @membership = Membership.new
        end

          def create

            # jos käyttäjä kuuluu jo klubiin
            current_user.memberships.each do |m|
                if m.beer_club_id == params[:membership][:beer_club_id].to_i
                    redirect_to current_user
                    return
                end
            end

            membership = Membership.create params[:membership]
            current_user.memberships << membership

            redirect_to current_user
          end

          def confirm
            membership = Membership.find(params[:id])
            membership.update_attribute :confirmed, true

            redirect_to :back, :notice => "#{membership.user.username} has been accepted as a member"
          end
end