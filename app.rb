require_relative './student'
require_relative './teacher'
require_relative './book'
require_relative './rental'
require_relative './data'

class App
  attr_reader :books, :people, :rentals

  def initialize
    @data = Data.new
    @books = @data.load_books
    @people = []
    @rentals = []
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    choice = gets.chomp.to_i

    case choice
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Incorrect choice'
      create_person
    end
  end

  def permission?
    print 'Has parent permission? [Y/N]:'
    permission = gets.chomp

    case permission.downcase
    when 'y'
      true
    when 'n'
      false
    else
      puts 'Invalid input'
      permission?
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    parent_permission = permission?

    student = Student.new(nil,nil, age, name, parent_permission)
    @people.push(student)
    puts 'Person created successfully'
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp

    teacher = Teacher.new(nil, specialization, age, name)
    @people.push(teacher)
    puts 'Person created successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    book = Book.new(nil,title, author)
    @books.push(book)
    @data.create_book(book)
    puts 'Book created successfully'
  end

  def book_list
    return puts 'No books found!' if @books.empty?

    @books.each_with_index do |book, index|
      puts "#{index + 1}) Title: #{book.title}, Author: #{book.author}"
    end
  end

  def people_list
    if @people.empty?
      puts 'No people found!'
    else
      @people.each_with_index do |person, index|
        puts "#{index + 1}) [#{person.class}] Name: #{person.name}, Age: #{person.age}, ID: #{person.id}"
      end
    end
  end

  def create_rental
    puts 'Select a book from the following list by number'
    book_list
    book_index = gets.chomp.to_i
    puts 'Select a person from the following list by number (not id)'
    people_list
    person_index = gets.chomp.to_i
    print 'Date: '
    date = gets.chomp

    rental = Rental.new(date, @books[book_index - 1], @people[person_index - 1])
    puts 'Rental created successfully'
  end

  def rental_list
    puts 'Enter ID of the person'
    people_list
    person_id = gets.chomp.to_i
    person = @people.select { |p| p.id == person_id }[0]
    person.rentals.each_with_index do |rental, index|
      puts "#{index + 1}) Book: #{rental.book.title}, Date: #{rental.date}"
    end
  end
end
