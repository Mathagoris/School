// Matthew Dohlen
// CS140, section 01
// Project 2 - Time Conversion Second
// 10/14/2013

import java.util.Scanner;

public class TimeConversionToSecond
{
   public static void main(String [] args)
   {
      Scanner kb = new Scanner(System.in);
      int hours, mins, secs;
      
      System.out.print("enter hours: ");
      hours = kb.nextInt();
      System.out.print("enter minutes: ");
      mins = kb.nextInt();
      System.out.print("enter seconds: ");
      secs = kb.nextInt();
      System.out.print(hours + " hours, " + mins + " minutes, " +
                       secs + " seconds is equivalent to ");
      secs += hours * 3600;
      secs += mins * 60;
      System.out.println(secs + " seconds.");
   }
}
