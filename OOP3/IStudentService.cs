namespace OOP3;

public interface IStudentService : IPersonService
{
    double GetStudentGPA(Student student);
}
