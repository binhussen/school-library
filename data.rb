require 'json'
require_relative './book'
require_relative './person'
require_relative './rental'

class Data
  def initialize
    @books = []
    @person = []
    @rentals = []
  end

  def load_books
    return [] unless File.size?('./data/book.json')

    stored_books = JSON.parse(File.read('./data/book.json'))
    stored_books.map do |book|
      @books << Book.new(book['id'], book['title'], book['author'])
    end
    @books
  end

  def create_book(book)
    if File.size?('./data/book.json')
      books_file = JSON.parse(File.read('./data/book.json'))
      books_file << { id: book.id, title: book.title, author: book.author }
      File.write('./data/book.json', JSON.pretty_generate(books_file))
    else
      File.write('./data/book.json', JSON.pretty_generate([{ id: book.id, title: book.title, author: book.author }]))
    end
  end

  def load_person
    return [] unless File.size?('./data/person.json')

    stored_person = JSON.parse(File.read('./data/person.json'))
    stored_person.map do |person|
      case person['type']
      when 'student'
        @person << Student.new(person['id'], nil, person['age'], person['name'], person['parent_permission'])
      when 'teacher'
        @person << Teacher.new(nil, person['specialization'], person['age'], person['name'])
      end
    end
    @person
  end

  def create_person(person)
    if File.size?('./data/person.json')
      person_file = JSON.parse(File.read('./data/person.json'))
      person_file << if person.instance_of? Student
                       { id: person.id, name: person.name, age: person.age, type: 'student',
                         parent_permission: person.parent_permission }
                     else
                       { id: person.id, name: person.name, age: person.age, specialization: person.specialization,
                         type: 'teacher' }
                     end
      File.write('./data/person.json', JSON.pretty_generate(person_file))
    else
      user_file = if person.instance_of? Student
                    { id: person.id, name: person.name, age: person.age, parent_permission: person.parent_permission,
                      type: 'student' }
                  else
                    { id: person.id, name: person.name, age: person.age, specialization: person.specialization,
                      type: 'teacher' }
                  end
      File.write('./data/person.json', JSON.pretty_generate([user_file]))
    end
  end

  def load_rentals
    return [] unless File.size?('./data/rental.json')

    stored_rentals = JSON.parse(File.read('./data/rental.json'))
    stored_rentals.map do |rental|
      p rental['book']
      p rental['person']
      book = @books.find { |x| x.id == rental['book'] }
      person = @person.find { |x| x.id == rental['person'] }
      @rentals << Rental.new(rental['date'], book, person)
    end
    @rentals
  end

  def create_rental(rental)
    if File.size?('./data/rental.json')
      rentals_file = JSON.parse(File.read('./data/rental.json'))
      rentals_file << { date: rental.date, book: rental.book.id, person: rental.person.id }
      File.write('./data/rentals.json', JSON.pretty_generate(rentals_file))
    else
      File.write('./data/rental.json',
                 JSON.pretty_generate([{ date: rental.date, book: rental.book.id, person: rental.person.id }]))
    end
  end
end
