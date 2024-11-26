require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  path '/api/v1/sessions' do
    post '用户登录' do
      tags 'Sessions'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            },
            required: [ 'email', 'password' ]
          }
        },
        required: [ 'user' ]
      }

      response '200', '用户登录成功' do
        let(:user) { { user: { email: 'test@example.com', password: 'password123' } } }

        before do
          User.create!(email: 'test@example.com', password: 'password123')
        end

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          json_response = JSON.parse(response.body)
          expect(json_response['jwt']).not_to be_nil
          expect(json_response['email']).to eq('test@example.com')
        end
      end

      response '401', '邮箱或密码错误' do
        let(:user) { { user: { email: 'test@example.com', password: 'password123' } } }

        run_test! do |response|
          expect(response).to have_http_status(:unauthorized)
          json_response = JSON.parse(response.body)
          expect(json_response['error']).to eq('邮箱或密码错误')
        end
      end
    end
  end
end
