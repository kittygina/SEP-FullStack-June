namespace OOP3;

public class Fibonacci
{
    public static int GetFibonacci(int n)
    {
        if (n <= 1)
            return n;
        return GetFibonacci(n - 1) + GetFibonacci(n - 2);
    }
}