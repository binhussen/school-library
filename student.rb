require_relative './person'

class Student < Person
  def initialize(classroom, age, name, parent_permission)
    super(age, name, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def addclassroom=(classroom)
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
