// Matt Dohlen
// CS140, section 01
// Project 4 - the game of craps
// November 12, 2013

import java.util.Scanner;
import java.util.Random;

public class Craps
{
   public static void main(String[] args)
   {
      Scanner kb = new Scanner(System.in);
      Random rand = new Random();

      int wins = 0;
      int losses = 0;
      int numGames;
      int roll;
      int point = 0;
      boolean printFlag = true;

      System.out.println("The Game of Craps:");
      System.out.print("How many games do you want to play in this " +
                       "simulation? ");
      numGames = kb.nextInt();
      if(numGames > 100)
         printFlag = false;
      for(int i = 0; i < numGames; ++i, point = 0)
      {
         roll = (rand.nextInt(6) + 1) + (rand.nextInt(6) + 1);
         if(printFlag == true)
            System.out.printf("[%5d]%6d", i + 1, roll);
         if(point == 0)
         {
            if(roll == 7 || roll == 11)
            {
               ++wins;
               if(printFlag == true)
                  System.out.printf("%6s\n", "win");
               continue;
            }
            else if(roll == 2 || roll == 3 || roll == 12)
            {
               ++losses;
               if(printFlag == true)
                  System.out.printf("%6s\n", "lose");
               continue;
            }
            else
               point = roll;
         }
	 while(true)
         {
            roll = (rand.nextInt(6) + 1) + (rand.nextInt(6) + 1);
            if(printFlag == true)
               System.out.printf("%6d", roll);
            if(roll == 7)
            {
               ++losses;
               if(printFlag == true)
                  System.out.printf("%6s\n", "lose");
               break;
            }
            else if(point == roll)
            {
               ++wins;
               if(printFlag == true)
                  System.out.printf("%6s\n", "win");
               break;
            }
         }
      }
      System.out.printf("In the simulation, you won %d time%s and", wins,
                        wins == 1 ? "" : "s");
      System.out.printf(" and lost %d time%s.\n", losses,
                        losses == 1 ? "" : "s");
      System.out.printf("The probability of winning is %f\n",
                         ((double)wins)/(losses + wins));
   }
}
