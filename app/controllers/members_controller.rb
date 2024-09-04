class MembersController < ApplicationController
#     before_action :set_current_member
#     before_action :test, only [:create]

    rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
    rescue_from StandardError, with: :handle_standard_error

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

        return render json: { error: member.errors }, status: :unprocessable_entity unless member.valid?

        if member.save
            render json: member, status: :created
        else
            render json: { error: member.errors }, status: :unprocessable_entity
        end
    end

    def update
        begin
            member = Member.find(params[:id])
            member_params = params.require(:member).permit(
              :phone_number
            )
            member.update(member_params)
            render json: member
        rescue ActiveRecord::RecordNotFound => e
            render json:{ error: member.errors }, status: :e.status
        end
    end

    def show
        begin
            member = Member.find(params[:id])
            render json: member, status: :ok
        rescue ActiveRecord::RecordNotFound => e
            render json: { error: 'Member not found' }, status: :not_found
        end
    end

    private

    def handle_parameter_missing(exception)
        render json: { error: "Required parameter missing: #{exception.param}" }, status: :bad_request
    end

    def handle_record_not_found
        render json: { error: 'Member not found' }, status: :not_found
    end

    def handle_record_invalid(exception)
        render json: { error: exception.record.errors }, status: :unprocessable_entity
    end

    def handle_standard_error(exception)
    # Log the error for debugging purposes
    Rails.logger.error(exception.message)
    Rails.logger.error(exception.backtrace.join("\n"))
    render json: { error: 'An unexpected error occurred' }, status: :internal_server_error
    end

#
#     def test
#         member_params = params.require(:member).permit(
#                   :phone_number,
#                 )
#     end
#     private
#
#     def set_current_member
#         Thread.current[:member] = member
#     end
#


end