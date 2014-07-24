// Matthew Dohlen
// CS140, section 01
// Project 2 - Time Conversion HMS
// 10/14/2013

import java.util.Scanner;

public class TimeConversionToHMS
{
   public static void main(String [] args)
   {
      Scanner kb = new Scanner(System.in);
      int secs, mins, hours;

      System.out.print("enter total seconds: ");
      secs = kb.nextInt();
      System.out.print(secs + " seconds is equivalent to ");
      hours = secs / 3600;
      mins = (secs % 3600) / 60;
      secs = ((secs % 3600) % 60);
      System.out.println(hours + " hours, " + mins + " minutes, " + secs + 
                       " seconds.");
   }
}
