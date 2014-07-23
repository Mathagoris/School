//Chapter 13, Pr 5 (Mixed_Call_Main.cpp)

// Program:     C_Assembly_Mixed_Call
// Description: Check whether an integer entered by the user is
//				prime or not
// Student:     Matt Dohlen
// Date:        05/20/2014
// Class:       CSCI 241
// Instructor:  Mr. Ding

#include <iostream>
#include <math.h>
using namespace std;


extern "C"{
	//external ASM Procedures
	bool isPrimeASM( int val );
	//local C++ functions
	int intSqrt(int n);
}

int main()
{
	int val;

	cout << "Enter an integer (-1 to exit): ";
	cin >> val;
	while(val >= 0)
	{
		if(isPrimeASM(val))
		{
			cout << val << " is prime." << endl;
		}
		else
		{
			cout << val << " is NOT prime." << endl;
		}
		cout << "Enter an integer (-1 to exit): ";
		cin >> val;
	}

  return 0;
}

int intSqrt(int n)
{
   return (int)sqrt((float)n);
}