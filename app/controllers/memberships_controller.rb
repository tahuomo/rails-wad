class MembershipsController  < ApplicationController
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
end