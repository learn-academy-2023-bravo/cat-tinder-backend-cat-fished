require 'rails_helper'

RSpec.describe Cat, type: :model do
  it "should have a name" do
    cat = Cat.create(age: 3, enjoys: "meowing", image: "catpic.jpg")
    expect(cat.errors[:name]).to_not be_empty  
  end

  it "should have a age" do 
    cat = Cat.create(name:'Buster', enjoys:'singing', image:'catcat.png')
    expect(cat.errors[:age]).to_not be_empty
  end

  it "should have an enjoys" do
    cat = Cat.create(name:'Meeko', age: 4, image: 'cat.png')
    expect(cat.errors[:enjoys]).to_not be_empty
  end

  it "should have an image" do
    cat = Cat.create(name:'Meeko', age: 4, enjoys: 'cat nip')
    expect(cat.errors[:image]).to_not be_empty
  end

  it "should have an enjoy statement >= 10" do
    cat = Cat.create(name: 'kitty', age: 2, image: 'cool.png', enjoys: '12345')
  end
end
