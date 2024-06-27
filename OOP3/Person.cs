namespace OOP3;

public abstract class Person
{
    public string Name { get; set; }
    public DateTime DateOfBirth { get; set; }
    public List<string> Addresses { get; set; } = new List<string>();

    public int CalculateAge()
    {
        DateTime today = DateTime.Today;
        int age = today.Year - DateOfBirth.Year;
        if (DateOfBirth.Date > today.AddYears(-age)) age--;
        return age;
    }

    public abstract void AddAddress(string address);
}
