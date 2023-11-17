# frozen_string_literal: true

require 'rails_helper'

module Queries
  RSpec.describe Member, type: :request do
    describe 'Member query' do
      let!(:member) { create(:member) }
      let(:query) do
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
      end

      let(:result) { KilnBackendSchema.execute(query).as_json }

      it 'returns the expected Member' do
        data = result['data']['member']

        expect(data).to include(
          'id' => member.id.to_s,
          'firstName' => member.first_name,
          'lastName' => member.last_name,
          'title' => member.title
        )
      end
    end
  end

  describe 'Members query' do
    let!(:members) { create_list(:member, 2) }
    let(:query) do
      <<~GQL
        query {
          members {
            id
            firstName
            lastName
            title
          }
        }
      GQL
    end

    let(:result) { KilnBackendSchema.execute(query).as_json }

    it 'returns all Members' do
      data = result['data']['members']

      expect(data).to include(
        {
          'id' => members[0].id.to_s,
          'firstName' => members[0].first_name,
          'lastName' => members[0].last_name,
          'title' => members[0].title
        },
        {
          'id' => members[1].id.to_s,
          'firstName' => members[1].first_name,
          'lastName' => members[1].last_name,
          'title' => members[1].title
        }
      )
    end
  end
end
