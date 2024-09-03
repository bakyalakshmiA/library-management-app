class MembersController < ApplicationController
    def index
        members = Member.all
        render json: members, status: :ok
    end

    def create
        member_params = params.require(:member).permit(
          :name,
          :email,
          :phone_number,
          :member_id,
          :started_at,
          :ended_at
        )
        member = Member.new(member_params)
        if member.save
            render json: member, status: :created
        else
            render json: { error: member.errors }, status: :unprocessable_entity
        end
    end

    def update
        member = Member.find(params[:id])
        member_params = params.require(:member).permit(
          :phone_number,
        )
        if member.update(member_params)
          render json: member
        else
          render json:{ error: member.errors }, status: :unprocessable_entity
        end
    end

end