import java.util.*;

/* Developer: Brady Lange
 * Date: 6/10/2018
 * This program gets user input and executes a condition based upon their input.
 */

public class UIHApp
{
	public static void main(String[] args) 
	{
		Scanner console = new Scanner(System.in);
		// Trying to get correct user input
		String str = "";
		boolean flag = false;
		int input = 0;
		do
		{
		    try 
		    {
			    // Grabbing user input
				System.out.println("Enter 1 for a surprise and 2 for a word of a praise: ");
		        input = console.nextInt();
		        int count = 0;
		        
		        switch(input)
		        {
		            case 1:
		                while(true)
		                {
		                    System.out.println("I bet you weren't expecting this kind of surprise... Times you've seen this: " + ++count);
		                    if(count == 50)
		                    {
		                        break;
		                    }
		                }
		            case 2:
		                System.out.println("Beautiful!");
		                break;
		            default:
		                System.out.println("You really couldn't type 1 or 2...?");
		                break;
		        }
		        
		        flag = true;
		        
		    }
		    
		    // Catch user errors
		    catch(NullPointerException npex)
		    {
		        System.out.println("Exception: " + npex.toString());
		    }
		    catch(InputMismatchException imex)
		    {
		        str = console.next();
		        System.out.println("Exception: " + imex.toString() + " " + str);
			    }
			    catch(NumberFormatException nfex)
			    {
			        System.out.println("Exception: " + nfex.toString());
			    }
			    catch(Exception ex)
			    {
			        ex.printStackTrace();
			    }
			    
		    } while(!flag);
			    
		   // Ending the program
		  System.out.println("Thank you using Brady Lange's program!");
		  System.out.println("Exiting now...");
		  
		  console.close();
	   
	
	}
}
