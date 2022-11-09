require_relative './app'

class Select
  def initialize
    @app = App.new
  end

  
def choice(choice)
  case choice
  when 1
    @app.book_list
  when 2
    @app.people_list
  when 3
    @app.create_person
  when 4
    @app.create_book
  when 5
    @app.create_rental
  when 6
    @app.rental_list
  else
    puts 'Invalid input'
  end
end
end