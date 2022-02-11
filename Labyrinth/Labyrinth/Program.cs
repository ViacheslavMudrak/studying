using System;

namespace Labyrinth
{
    class Program
    {            
        const int m = 4;
        const int n = 4;
        static int[,] maze = new int[m, n];
        static int count = 0;

        static void Main(string[] args)
        {
            Initialize(maze);
            Iterate(maze);
            DisplayArr(maze);
            Step(m - 1, 0);
            Console.WriteLine();
            Console.WriteLine(count > 0 ? $"  Possible ways number: {count}" : "  Impossible to rescue");
        }

        static void Step(int i, int j)
        {
            if (i > 0 && maze[i - 1, j] == 1)
                Step(i - 1, j);
            if (j < n - 1 && maze[i, j + 1] == 1)
                Step(i, j + 1);
            if (i == 0 && j == n - 1)
                count++;
        }

        static void Initialize(int[,] arr)
        {
            for (int i = 0; i < m; i++)
            {
                for (int j = 0; j < n; j++)
                {
                    arr[i, j] = new Random().Next(0, 2);
                }
            }
            arr[0, n - 1] = arr[m - 1, 0] = 1;
        }

        static void DisplayArr(int[,] arr)
        {
            for (int i = 0; i < m; i++)
            {
                for (int j = 0; j < n; j++)
                {
                    Console.Write("  " + arr[i, j]);
                }
                Console.WriteLine();
            }
        }

        static void Iterate(int[,] arr)
        {
            for (int i = 0; i < m; i++)
            {
                for (int j = 0; j < n; j++)
                {
                    if(arr[i, j] == 0)
                        arr[i, j] = new Random().Next(0, 2);
                }
            }
        }
    }
}
