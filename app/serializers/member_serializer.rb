class MemberSerializer < ActiveModel::Serializer
  attributes :id, :name, :email,:phone_number,:member_id, :started_at,:ended_at
end
