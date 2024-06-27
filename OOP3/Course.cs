namespace OOP3;

public class Course
{
    public string CourseName { get; set; }
    public List<Student> EnrolledStudents { get; set; } = new List<Student>();
    public int GradePoint { get; set; }
}


