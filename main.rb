require_relative './app'

def main
  puts 'Welcome to School Library App!'
  app = App.new
  loop do
    puts "\nPlease choose an option by enetering a number:"
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'

    choice = gets.chomp.to_i
    if choice == 7
      puts 'Thanks for using this app!'
      break
    end

    choice(app, choice)
  end
end

def choice(app, choice)
  case choice
  when 1
    app.book_list
  when 2
    app.people_list
  when 3
    app.create_person
  when 4
    app.create_book
  when 5
    app.create_rental
  when 6
    app.rental_list
  else
    puts 'Invalid input'
  end
end

main
