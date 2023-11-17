# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :members, [MemberType], null: false, description: "Fetches all members"
    def members
      Member.all.order("first_name ASC")
    end

    field :member, MemberType, null: true, description: "Fetches a member by first_name" do
      argument :first_name, String, required: true, description: "First name of the member"
    end
    def member(first_name:)
      Member.find_by(first_name: first_name)
    end
  end
end
