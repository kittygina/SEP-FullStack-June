namespace OOP3;

public interface IPersonService
{
    void AddPerson(Person person);
    Person GetPerson(string name);
    void UpdatePerson(Person person);
    void DeletePerson(Person person);
}
