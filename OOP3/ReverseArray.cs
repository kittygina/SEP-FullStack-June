namespace OOP3;

using System;
public static class ReverseArray
    {
        public static int[] GenerateNumbers(int length)
        {
            int[] numbers = new int[length];
            for (int i = 0; i < length; i++)
            {
                numbers[i] = i + 1;
            }
            return numbers;
        }

        public static void Reverse(int[] array)
        {
            int temp;
            for (int i = 0; i < array.Length / 2; i++)
            {
                temp = array[i];
                array[i] = array[array.Length - i - 1];
                array[array.Length - i - 1] = temp;
            }
        }

        public static void PrintNumbers(int[] array)
        {
            foreach (int number in array)
            {
                Console.Write(number + " ");
            }
            Console.WriteLine();  
        }
}
