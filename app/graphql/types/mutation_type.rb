# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_member, MemberType, null: true do
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :title, String, required: true
    end
    def create_member(first_name:, last_name:, title:)
      Member.create(
        first_name: first_name,
        last_name: last_name,
        title: title
      )
    end

    field :delete_member, Boolean, null: false do
      argument :id, ID, required: true
    end
    def delete_member(id:)
      member = Member.find(id)
      return false unless member

      member.destroy
      true
    end
  end
end
