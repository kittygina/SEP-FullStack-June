namespace OOP3;

public class Student : Person
{
    public List<Course> Courses { get; set; } = new List<Course>();

    public override void AddAddress(string address)
    {
        Addresses.Add(address);
    }

    public double CalculateGPA()
    {
        // Simplified GPA calculation logic
        return Courses.Average(c => c.GradePoint); // Assume GradePoint is a property within Course
    }
}
