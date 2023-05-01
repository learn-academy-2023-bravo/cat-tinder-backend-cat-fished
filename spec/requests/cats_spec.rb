require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it "gets a list of cats" do
       Cat.create(
        name: "Kitty",
        age: 1,
        enjoys: "break dancing",
        image: "cat.com/url"
       )
       get '/cats'
       cat = JSON.parse(response.body)
       expect(response).to have_http_status(200)
       expect(cat.length).to eq 1 
    end
  end

  describe "POST /create" do
    it "creates a cat" do
      cat_params = {
        cat: {
        name: "Kitty",
        age: 1,
        enjoys: "break dancing",
        image: "cat.com/url"
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(200)
      cat = Cat.first
      expect(cat.name).to eq 'Kitty'
      expect(cat.age).to eq 1
      expect(cat.enjoys).to eq 'break dancing'
      expect(cat.image).to eq 'cat.com/url'

    end
    end
    describe "DELETE /destroy" do
      it "deletes a cat" do
        kitty = Cat.create(
          name: "Kitty",
          age: 1,
          enjoys: "break dancing",
          image: "cat.com/url"
         )
         delete "/cats/#{kitty.id}"
         expect(response).to have_http_status(200)
         expect(Cat.count).to eq(0) 
         
      end
      end
      describe "PATCH/PUT /update" do
        it "updates a cat" do
          kitty = Cat.create(
            name: "Kitty",
            age: 1,
            enjoys: "break dancing",
            image: "cat.com/url"
          )
      
          cat_params = {
            cat: {
              name: "Kitty123",
              age: 1,
              enjoys: "break dancing",
              image: "cat.com/url"
            }
          }
      
          patch "/cats/#{kitty.id}", params: cat_params
      
          expect(response).to have_http_status(200)
      
          kitty.reload
      
          expect(kitty.name).to eq 'Kitty123'
          expect(kitty.age).to eq 1
          expect(kitty.enjoys).to eq 'break dancing'
          expect(kitty.image).to eq 'cat.com/url'
        end
      end

end
