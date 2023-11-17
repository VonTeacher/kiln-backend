require "rails_helper"

module Queries
  RSpec.describe Member, type: :request do
    describe "member query" do
      let!(:member) { create(:member) }
      let(:member_query) {
        <<~GQL
          query {
            member(firstName: "#{member.first_name}") {
              id
              firstName
              lastName
              title
            }
          }
        GQL
      }

      let(:result) { KilnBackendSchema.execute(member_query).as_json }

      it "returns the expected Member" do
        data = result["data"]["member"]

        expect(data).to include(
          "id" => member.id.to_s,
          "firstName" => member.first_name,
          "lastName" => member.last_name,
          "title" => member.title
        )
      end
    end
  end
end
