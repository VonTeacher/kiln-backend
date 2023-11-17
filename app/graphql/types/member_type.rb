# frozen_string_literal: true

module Types
  class MemberType < Types::BaseObject
    description "A Kiln Collective member"

    field :id, ID, null: false
    field :first_name, String
    field :last_name, String
    field :title, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
