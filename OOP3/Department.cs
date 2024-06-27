namespace OOP3;

public class Department
{
    public string DepartmentName { get; set; }
    public Instructor Head { get; set; }
    public List<Course> Courses { get; set; } = new List<Course>();
    public decimal Budget { get; set; }
}