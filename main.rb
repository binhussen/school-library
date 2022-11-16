require_relative './select'

def main
  puts 'Welcome to School Library App!'
  select = Select.new
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

    select.choice(choice)
  end
end
main
