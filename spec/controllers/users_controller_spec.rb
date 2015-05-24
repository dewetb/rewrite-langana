require 'spec_helper'

describe UsersController do
  let(:user) { create(:user) }  
  describe 'GET show' do
    it 'should return http 200' do
      get :index
      expect(response.code).to eq("200")
    end
  end

  describe 'GET activate' do
    it 'should return http 200' do
      get :activate, id: user.id
      expect(response.code).to eq("200")
    end
  end
end