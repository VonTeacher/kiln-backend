# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe Member, type: :request do
    describe 'Member create mutation' do
      let(:mutation) do
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
      end

      let(:result) { KilnBackendSchema.execute(mutation).as_json }

      it 'returns the created Member' do
        data = result['data']['createMember']

        expect(data).to include(
          {
            'id' => be_present,
            'firstName' => 'Test'
          }
        )
        expect(Member.count).to be 1
      end
    end

    describe 'Member delete mutation' do
      let!(:result) { KilnBackendSchema.execute(mutation).as_json }

      context 'when member exists' do
        let(:member) { create(:member) }
        let(:mutation) do
          <<~GQL
            mutation {
              deleteMember(id: "#{member.id}")
            }
          GQL
        end

        it 'returns true' do
          data = result['data']['deleteMember']
          expect(data).to be true
          expect(Member.count).to be 0
        end
      end

      context 'when member does not exist' do
        let(:mutation) do
          <<~GQL
            mutation {
              deleteMember(id: "999")
            }
          GQL
        end

        it 'returns false' do
          expect(result['data']['deleteMember']).to be false
        end
      end
    end
  end
end
