namespace OOP3;

public class Instructor : Person
{
    public DateTime JoinDate { get; set; }
    public decimal Salary { get; set; }
    public bool IsHeadOfDepartment { get; set; }

    public override void AddAddress(string address)
    {
        Addresses.Add(address);
    }

    public decimal CalculateSalary()
    {
        // Basic salary calculation, could be extended
        return Salary;
    }
}
