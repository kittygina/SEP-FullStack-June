using OOP3;

class Program
{
    public static void Main(string[] args)
    {
        
        Console.WriteLine("First 10 Fibonacci numbers:");
        for (int i = 0; i < 10; i++)
        {
            Console.WriteLine(Fibonacci.GetFibonacci(i));
        }

        // Demonstrating array operations
        Console.WriteLine("\nArray Operations:");
        int[] numbers = ReverseArray.GenerateNumbers(10);  // Generate an array of 10 numbers
        ReverseArray.Reverse(numbers);                     // Reverse the array
        Console.Write("Reversed Array: ");
        ReverseArray.PrintNumbers(numbers);                // Print the reversed array
        
        
        // Create and manipulate instances of students and instructors here
        Student student = new Student { Name = "Regina", DateOfBirth = new DateTime(1998, 04, 27) };
        student.AddAddress("21 Lomb Memorial Drive");

        Instructor instructor = new Instructor { Name = "Mr. Leo", DateOfBirth = new DateTime(1961, 12, 8), Salary = 50000 };
        instructor.AddAddress("1 Lomb Memorial Drive");

        Console.WriteLine($"Student Age: {student.CalculateAge()}");
        Console.WriteLine($"Instructor Salary: {instructor.CalculateSalary()}");
    }
}

