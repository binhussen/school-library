require_relative './person'

class Student < Person
  attr_accessor :parent_permission

  def initialize(id, classroom, age, name, parent_permission)
    super(id, age, name)
    @classroom = classroom
    @parent_permission = parent_permission
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def addclassroom=(classroom)
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
