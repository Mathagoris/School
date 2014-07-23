//Chapter 13, Inline assembly (Prime_Check.cpp)

// Program:     Prime_Check
// Description: Check whether an integer entered by the user is
//				prime or not
// Student:     Matt Dohlen
// Date:        05/20/2014
// Class:       CSCI 241
// Instructor:  Mr. Ding

#include <iostream>
using namespace std;

//function prototype
bool isPrimeC_inlineASM(int n);
bool isPrimeC_inlineASM2(int n);

int main()
{
	int val;

	cout << "Enter an integer (-1 to exit): ";
	cin >> val;
	while(val >= 0)
	{
		if(isPrimeC_inlineASM(val) && isPrimeC_inlineASM2(val))
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

bool isPrimeC_inlineASM(int n)
{
  __asm {
	  mov ecx,2
	  mov ebx,n
	  shr ebx,1
next:
	  cmp ecx,ebx
	  jle L1
	  mov eax,1
	  jmp quit
L1:
	  mov edx,0
	  mov eax,n
	  div ecx
	  cmp edx,0
	  jne L2
	  mov eax,0
	  jmp quit
L2:
	  inc ecx
	  jmp next
quit:
    }		// asm
}

bool isPrimeC_inlineASM2(int n)
{
    bool isPrime = true;
    for (int divisor = 2; divisor <= n / 2; divisor++)
    {
        __asm {
          
			mov edx,0
			mov eax,n
			div divisor
			cmp edx,0
			jne L3
			mov isPrime,0
L3:

          }		// asm

        if (!isPrime)
            break;
    }
    return isPrime;
}