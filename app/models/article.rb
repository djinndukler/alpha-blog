class Article < ActiveRecord::Base
    validades :title, presence: true, length: { minimum: 3, maximum: 50 }
    validades :description, presence: true, length: { minimum: 10, maximum: 300 } 
end