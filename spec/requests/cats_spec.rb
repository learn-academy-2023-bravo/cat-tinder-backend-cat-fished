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

      describe "cannot create a cat without valid attributes" do
        it "cannot create a cat without a name" do 
          cat_params = {
            cat: {
              age: 2,
              enjoys: '1234567891011',
              image: 'cat.png'
            }
          }
          post "/cats", params: cat_params
          cat = JSON.parse(response.body)
          expect(response).to have_http_status(422)
          expect(cat['name']).to include "can't be blank"
        end

        it 'cannot create a cat without an age' do
          cat_params = {
            cat: {
              name: 'kitty',
              image: 'image.png',
              enjoys: 'having a lot of fun in da sun'
            }
          }
          post "/cats", params: cat_params
          cat = JSON.parse(response.body)
          expect(response).to have_http_status(422)
          expect(cat['age']).to include "can't be blank"
        end

        it 'cannot create a cat without an image' do
          cat_params = {
            cat: {
              name: 'kitty',
              age: 2,
              enjoys: 'having a lot of fun in da sun'
            }
          }
          post "/cats", params: cat_params
          cat = JSON.parse(response.body)
          expect(response).to have_http_status(422)
          expect(cat['image']).to include "can't be blank"
        end

        it 'cannot create a cat without an enjoys' do
          cat_params = {
            cat: {
              name: 'kitty',
              image: 'image.png',
              age: 2
            }
          }
          post "/cats", params: cat_params
          cat = JSON.parse(response.body)
          expect(response).to have_http_status(422)
          expect(cat['enjoys']).to include "can't be blank"
        end
      end










      describe "cannot update a cat without valid attributes" do
        it "cannot update a cat without a age" do
          cat_params = {
            cat: {
              name: 'boo',
              age: 2,
              enjoys: 'laying in theeee sunnnnn',
              image: 'caturl.png'
            }
          }
          post "/cats", params: cat_params
          cat = Cat.first

          update_params = {
            cat: {
              name: "bob",
              age: nil,
              image: 'catuyrl.png',
              enjoys: 'ignoring everybody in the house' 
            }
          }
          patch "/cats/#{cat.id}", params: update_params
          cat = JSON.parse(response.body)
          expect(response).to have_http_status(422)
          expect(cat['age']).to include "can't be blank"
          end  
      

      it "cannot update a cat without a enjoys" do
        cat_params = {
          cat: {
            name: 'boo',
            age: 2,
            enjoys: 'laying in theeee sunnnnn',
            image: 'caturl.png'
          }
        }
        post "/cats", params: cat_params
        cat = Cat.first

        update_params = {
          cat: {
            name: "hopscotch",
            age: 2,
            image: 'catuyrl.png',
            enjoys: nil 
          }
        }
        patch "/cats/#{cat.id}", params: update_params
        cat = JSON.parse(response.body)
        expect(response).to have_http_status(422)
        expect(cat['enjoys']).to include "can't be blank"
        end  
    

    it "cannot update a cat without a name" do
      cat_params = {
        cat: {
          name: "hopscotch",
          age: 2,
          enjoys: 'laying in theeee sunnnnn',
          image: 'caturl.png'
        }
      }
      post "/cats", params: cat_params
      cat = Cat.first

      update_params = {
        cat: {
          name: nil,
          age: 2,
          image: 'catuyrl.png',
          enjoys: 'ignoring everybody in the house' 
        }
      }
      patch "/cats/#{cat.id}", params: update_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['name']).to include "can't be blank"
      end  
  

  it "cannot update a cat without an image" do
    cat_params = {
      cat: {
        name: 'boo',
        age: 2,
        enjoys: 'laying in theeee sunnnnn',
        image: 'caturl.png'
      }
    }
    post "/cats", params: cat_params
    cat = Cat.first

    update_params = {
      cat: {
        name: 'hank',
        age: 2,
        image: nil,
        enjoys: 'ignoring everybody in the house' 
      }
    }
    patch "/cats/#{cat.id}", params: update_params
    cat = JSON.parse(response.body)
    expect(response).to have_http_status(422)
    expect(cat['image']).to include "can't be blank"
    end  
end
end

