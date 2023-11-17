# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_member, MemberType, null: true, description: 'Create a new member' do
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :title, String, required: true
    end
    def create_member(first_name:, last_name:, title:)
      Member.create(
        first_name:,
        last_name:,
        title:
      )
    end

    field :delete_member, Boolean, null: false, description: 'Delete a member permanently' do
      argument :id, ID, required: true
    end
    def delete_member(id:)
      member = Member.find_by(id:)
      return false unless member

      member.destroy
      true
    end
  end
end
