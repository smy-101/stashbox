require 'swagger_helper'

RSpec.describe 'ValidationCodes', type: :request do
  path '/api/v1/validation_codes' do
    post '发送验证码' do
      tags 'ValidationCodes'
      consumes 'application/json'
      parameter name: :validation_code, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string }
        },
        required: [ 'email' ]
      }

      response '200', '验证码发送成功' do
        let(:validation_code) { { email: 'shimy1011@foxmail.com' } }

        run_test! do |response|
          expect(response).to have_http_status(:ok)
        end
      end

      response '429', '请求过于频繁' do
        let(:validation_code) { { email: 'shimy1011@foxmail.com' } }

        before do
          # 先发送一次请求，期望返回200
          post '/api/v1/validation_codes', params: validation_code.to_json, headers: { 'Content-Type': 'application/json' }
          expect(response).to have_http_status(:ok)
        end

        run_test! do |response|
          # 第二次请求，期望返回429
          post '/api/v1/validation_codes', params: validation_code.to_json, headers: { 'Content-Type': 'application/json' }
          expect(response).to have_http_status(:too_many_requests)
        end
      end
    end
  end
end
