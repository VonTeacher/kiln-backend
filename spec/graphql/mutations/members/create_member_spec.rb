require "rails_helper"

module Mutations
  RSpec.describe Member, type: :request do
    describe "Member create mutation" do
      let(:mutation) {
        <<~GQL
          mutation {
            createMember(
              firstName: "Test",
              lastName: "Member",
              title: "Disposable"
            ) {
              id
              firstName
            }
          }
        GQL
      }

      let(:result) { KilnBackendSchema.execute(mutation).as_json }

      it "returns the created Member" do
        data = result["data"]["createMember"]

        expect(data).to include(
          {
            "id" => be_present,
            "firstName" => "Test"
          }
        )
      end
    end
  end
end
