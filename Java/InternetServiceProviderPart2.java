//Matthew Dohlen
//CS140, section 01
//Project 3 - Internet Service Monthly Bill program
//October 24, 2013

import java.util.Scanner;
import java.text.DecimalFormat;


public class InternetServiceProviderPart1
{
   private static final float PACK_A = (float)9.95;
   private static final float PACK_B = (float)13.95;
   private static final float PACK_C = (float)19.95;
   private static final int HOURS_A = 10;
   private static final int HOURS_B = 20;
   
   public static void main(String [] args)
   {
      Scanner kb = new Scanner(System.in);
      DecimalFormat formatter = new DecimalFormat("$0.00");
	  
      String pack;
      int numHours;
      char packChar;
      float temp;
	  
      System.out.print("Enter the customer's package (A, B, or C): ");
      pack = kb.nextLine();
      if(pack.length() != 1)
      {
         System.out.println("Invalid package. Enter A, B, or C.");
	 System.exit(0);
      }
      packChar = pack.charAt(0);
      if(packChar != 'A' && packChar != 'B' && packChar != 'C')
      {
         System.out.println("Invalid package. Enter A, B, or C.");
	 System.exit(0);
      }
      System.out.print("Enter the number of hours used: ");
      numHours = kb.nextInt();
      if(numHours < 0 || numHours > (31 * 24))
      {
         System.out.println("Invalid input. Please enter number of hours" +
                            " between 0 and 744.");
         System.exit(0);
      }
      switch(packChar)
      {
         case 'A':
            if(numHours < HOURS_A)
	       temp = PACK_A;
	    else
               temp = PACK_A + (2 * (numHours - HOURS_A));
            System.out.println("The charges are " + formatter.format(temp));
            if(temp > PACK_B)
			{
			   System.out.println("With package B you would have saved " +
			                      formatter.format(temp - PACK_B));
			   if(temp > PACK_C)
			      System.out.println("With package C you would have saved " +
				                     formatter.format(temp - PACK_C));
			}
			break;
         case 'B':
            if(numHours < HOURS_B)
	       temp = PACK_B;
       	    else
               temp = PACK_B + (1 * (numHours - HOURS_B));
            System.out.println("The charges are " + formatter.format(temp));
		if(temp > PACK_C)
			      System.out.println("With package C you would have saved " +
				                     formatter.format(temp - PACK_C));
	    break;
         case 'C':
            temp = PACK_C;
            System.out.println("The charges are " + formatter.format(temp));
	    break;
         default:
            System.out.println("Invalid input. Try again!");
	    System.exit(0);
      }
   }
}
