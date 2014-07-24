// Matthew Dohlen
// CS140, section 01
// Project 6 - Arrays and File IO
// December 5, 2013


import java.util.Scanner;
import java.io.*;

public class ArrayProcessing
{
   public static void main(String[] args)
   {
      int[] a = {};
      try{
         a = inputData();
      }catch(IOException e){}
      int size = a.length;
      System.out.println("\noriginal array:");
      printArray(a, size);
      int order = outOfOrder(a);
      if(-1 == order)
         System.out.println("the array is in order\n");
      else
         System.out.println("the 1st element out of order is at index " +
                            order + "\n");
      reverseArray(a);
      System.out.println("reversed array:");
      printArray(a, size);
      System.out.println("max = " + max(a));
      System.out.println("min = " + min(a) + "\n");
      selectionSort(a);
      System.out.println("sorted array in descending order:");
      printArray(a, size);
      System.out.println("delete repeats:");
      size = deleteRepeats(a);
      printArray(a, size);
      try{
         outputData(a, size);
      }catch(IOException e){}
      System.out.println("Done, please check files 'even.out' and 'odd.out'.");
   }
   public static int[] inputData() throws IOException
   {
      Scanner kb = new Scanner(System.in);
      
      System.out.print("enter input filename: ");
      String filename = kb.nextLine();
      File userFile = new File(filename);
      if(!userFile.exists())
      {
         System.out.println("sorry, file does not exist, goodbye...");
         System.exit(0);
      }
      Scanner inFile = new Scanner(userFile);
      int size = inFile.nextInt();
      int[] intArray = new int[size];
      for(int i = 0; i < size; i++)
      {
         intArray[i] = inFile.nextInt();
      }
      //userFile.close();
      return intArray;
   }
   public static void printArray(int[] array, int counter)
   {
      int j = 0;
      for(int i = 0; i < counter; i++, j++)
      {
         if(j == 10)
         {
            System.out.println();
            j = 0;
         }
         System.out.printf("%6d", array[i]);
      }
      System.out.println("\n");
   }
   public static int outOfOrder(int[] array)
   { 
      if(array.length > 1)
      {
         for(int i = 0; i < array.length; ++i)
         {
            if(array[i] > array[i + 1])
               return i + 1;
         }
      }
      return -1;
   }
   public static void reverseArray(int[] array)
   {
      int f, l, temp;
      for(f = 0, l = array.length - 1; f < l; ++f, --l)
      {
         temp = array[f];
         array[f] = array[l];
         array[l] = temp;
      }
   }
   public static int max(int[] array)
   {
      int max = array[0];
      for(int i = 1; i < array.length; ++i)
      {
         if(array[i] > max)
            max = array[i];
      }
      return max;
   }
   public static int min(int[] array)
   {
      int min = array[0];
      for(int i = 1; i < array.length; ++i)
      {
         if(array[i] < min)
            min = array[i];
      }
      return min;
   }
   public static void selectionSort(int[] array)
   {
      int temp;
      for(int i = 0; i < array.length - 1; ++i)
      {
         for(int j = i + 1; j < array.length; ++j)
         {
            if(array[j] > array[i])
            {
               temp = array[j];
               array[j] = array[i];
               array[i] = temp;
            }
         }
      }
   }
   public static int deleteRepeats(int[] array)
   {
      int size = array.length;
      int temp;
      for(int i = 0; i < size - 1; ++i)
      { 
         for(int j = i + 1; j < size; ++j)
         {  
            if(array[i] == array[j])
            {
               for(int k = j; k < size - 1; ++k)
               {
                  array[k] = array[k + 1];
               }
            --size;
            --j;
            }
         }
      }
      return size;
   }
   public static void outputData(int[] array, int counter)throws IOException
   {
      PrintWriter even = new PrintWriter("even.out");
      PrintWriter odd = new PrintWriter("odd.out");
    
      for(int i = 0; i < counter; ++i)
      {
         if(array[i] % 2 == 0)
            even.println(array[i]);
         else
            odd.println(array[i]);
      }
   even.close();
   odd.close();
   }
}
