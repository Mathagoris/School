// Matthew Dohlen
// CS 140, section 01
// Project 5 - Rock, Paper, Scissors Game
// 11/26/2013

import java.util.Scanner;
import java.util.Random;

public class RockPaperScissorsGame
{
   public static void main(String[] args)
   {      
      String user, comp;
      boolean again;
 
      do {
         comp = computerChoice();
         user = userChoice();
         System.out.printf("The computer's choice was %s.\n", comp);
         System.out.printf("The user's choice was %s.\n\n", user);
         determineWinner(comp, user);
         if(comp.equalsIgnoreCase(user))
            again = true;
         else
            again = playAgain();
      } while(again);
   }
   public static String computerChoice()
   {
      Random rand = new Random();
      int result = rand.nextInt(3) + 1;

      if(result == 1)
         return "rock";
      else if(result == 2)
         return "paper";
      else
         return "scissors";
   }
   public static String userChoice()
   {
      Scanner kb = new Scanner(System.in);
      String input;
  
      System.out.print("Enter rock, paper, or scissors: ");
      input = kb.nextLine();
      while(!isValidChoice(input))
      {
         System.out.print("Invalid input, enter rock, paper, or scissors: ");
         input = kb.nextLine();
      }
      return input;
   }
   public static boolean isValidChoice(String choice)
   {
      if(choice.equalsIgnoreCase("rock") || choice.equalsIgnoreCase("paper")
         || choice.equalsIgnoreCase("scissors"))
         return true;
      else
         return false;
   }
   public static void determineWinner(String computer, String user)
   {
      switch(user.charAt(0))
      {
         case 'r': case 'R':
            switch(computer.charAt(0))
            {
               case 'r': case 'R':
                  System.out.println("The game is tied!\n" +
                                     "Get ready to play again...\n");
                  break;
               case 's': case 'S':
                  System.out.println("Rock smashes scissors.\n" +
                                     "The user wins!\n");
                  break;
               case 'p': case 'P':
                  System.out.println("Paper wraps rock.\n" +
                                     "The computer wins!\n");
                  break;
            }
            break;
         case 'p': case 'P':
            switch(computer.charAt(0))
            {
               case 'r': case 'R':
                  System.out.println("Paper wraps rock.\n" +
                                     "The user wins!\n");
                  break;
               case 's': case 'S':
                  System.out.println("Scissors cut paper.\n" +
                                     "The computer wins!\n");
                  break;
               case 'p': case 'P':
                  System.out.println("The game is tied!\n" +
                                     "Get ready to play again...\n");
                  break;
            }
            break;
         case 's': case 'S':
             switch(computer.charAt(0))
            {
               case 'r': case 'R':
                  System.out.println("Rock smashes scissors.\n" +
                                     "The computer wins!\n");
                  break;
               case 's': case 'S':
                  System.out.println("The game is tied!\n" +
                                     "Get ready to play again...\n");
                  break;
               case 'p': case 'P':
                  System.out.println("Scissors cut paper.\n" +
                                     "The user wins!\n");
                  break;
            }
            break;
      }
   }
   public static boolean playAgain()
   { 
      Scanner kb = new Scanner(System.in);
      String result;
      do{
         System.out.print("Play again? (y/n) ");
         result = kb.nextLine();
         if(result.equalsIgnoreCase("y") || result.equalsIgnoreCase("yes"))
            return true;
         else if(result.equalsIgnoreCase("n") ||
                 result.equalsIgnoreCase("no"))
            return false;
         else
            System.out.println("Invalid entry...");
      }while(true);
   }
}







