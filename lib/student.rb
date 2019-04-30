class Student

attr_accessor :id, :name, :grade
@@all = []

  def self.new_from_db(row)
    @student = self.new
    @student.id = row[0]
    @student.name = row[1]
    @student.grade = row[2]
  end

  def self.all
    arry = DB[:conn].execute(
    SQL <<- SELECT * FROM students
    SQL
    )
    arry.collect do
      |row| self.new_from_db(row)
    end
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
  end

  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
