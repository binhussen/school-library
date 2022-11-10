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
      books_file << { id:book.id,title: book.title, author: book.author }
      File.write('./data/book.json', JSON.pretty_generate(books_file))
    else
      File.write('./data/book.json', JSON.pretty_generate([{ id:book.id,title: book.title, author: book.author }]))
    end
  end

end