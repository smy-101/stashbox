# spec/requests/api/v1/users_spec.rb
require 'swagger_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  path '/api/v1/users' do
    post '创建用户' do
      tags 'Users'
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

      response '201', '用户创建成功' do
        let(:user) { { user: { email: 'test@example.com', password: 'password123' } } }

        run_test! do |response|
          expect(response).to have_http_status(201)
        end
      end

      response '422', '参数错误' do
        let(:user) { { user: { email: 'invalid' } } }

        run_test! do |response|
          p response.body
          expect(response).to have_http_status(422)
        end
      end
    end
  end

  # path '/api/v1/users/me' do
  #   get '获取当前用户信息' do
  #     tags 'Users'
  #     produces 'application/json'
  #     security [ bearer_auth: [] ]

  #     response '200', '成功获取用户信息' do
  #       let(:user) { User.create(email: 'test@example.com', password: 'password123') }
  #       let(:Authorization) { "Bearer #{generate_token(user)}" }

  #       run_test! do |response|
  #         expect(response).to have_http_status(200)
  #       end
  #     end

  #     response '401', '未授权' do
  #       let(:Authorization) { 'Bearer invalid' }

  #       run_test! do |response|
  #         expect(response).to have_http_status(401)
  #       end
  #     end
  #   end
  # end
end
