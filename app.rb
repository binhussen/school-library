require_relative './student'
require_relative './teacher'
require_relative './book'
require_relative './rental'

class App
  attr_reader :books, :people, :rentals
  
  def initialize
    @books = []
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

    student = Student.new(nil, age, name, parent_permission)
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

    teacher = Teacher.new(specialization, age, name)
    @people.push(teacher)
    puts 'Person created successfully'
  end
end