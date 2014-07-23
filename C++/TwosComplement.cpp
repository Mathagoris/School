// ============================================================================
// File:		TwosComplement.cpp
// Program:     Twos_Complement_with_Hexadecimal
// Description: Converts a (SIZE_OF_HEX)-digit Hexadecimal integer to its
//				Two's Complement
// Student:     Matt Dohlen
// Date:        02/21/2014
// Class:       CSCI 241
// Instructor:  Mr. Ding
// ============================================================================

#include <iostream>
using namespace std;

void TwosComplement(char* s, char* s2);
bool CheckHex(char* s);
int HexConversion(char c);
char IntConversion(int i);

const int SIZE_OF_HEX = 4; //must change example in input prompt (e.g, XXXX)

int main(void)
{
	char	hex[256];
	char	twos[5];
	char	ans;
	bool	lFlag = true;

	while(lFlag)
	{
		cout << "Please Enter 4-digit Hexadecimal integer (e.g., A1B2): ";
		cin >> hex;
		if(strlen(hex) != SIZE_OF_HEX || !CheckHex(hex))
		{
			cout << "Two's Complement of Hex " << hex << " is Error"  << endl;
		}
		else
		{
			TwosComplement(hex, twos);
			cout << "Two's Complement of Hex " << hex << " is " << twos << endl;
		}
		cout << "Try again? (y/n) ";
		cin >> ans;
		if(!(toupper(ans) == 'Y'))
		{
			lFlag = false;
		}
		cout << endl;
	}
}

// ============================================================================
// Function:	TwosComplement
// Description:	This function converts a Hexadecimal to its Two's Complement
//
// Parameter:   s [IN] - a C-string with a (SIZE_OF_HEX)-digit Hexadecimal 
//						 received
//              s2 [out] - a C-string with a (SIZE_OF_HEX)-digit of s two's 
//						   complement
// Return:      None
// ============================================================================

void TwosComplement(char* s, char* s2)
{
	char	temp;
	int		conv;
	int		carry = 1;

	for(int i = 0; i < SIZE_OF_HEX; ++i)
	{
		temp = toupper(s[SIZE_OF_HEX - (1 + i)]);
		conv = HexConversion(temp);
		conv = abs(conv - 15);
		conv += carry;
		if(conv == 16)
		{
			conv = 0;
			carry = 1;
		}
		else
		{
			carry = 0;
		}
		s2[SIZE_OF_HEX - (1 + i)] = IntConversion(conv);
	}
	s2[SIZE_OF_HEX] = NULL;
}

// ============================================================================
// Function:	CheckHex
// Description:	Checks to make sure the C-string is a proper Hexadecimal number
// Parameter:	s [IN] - a C-string with a Hex number
// Return:		true if proper, false if not
// ============================================================================

bool CheckHex(char* s)
{
	char	temp;
	int		conv;

	for(int i = 0; i < SIZE_OF_HEX; ++i)
	{
		temp = toupper(s[SIZE_OF_HEX - (1 + i)]);
		conv = HexConversion(temp);
		if(conv < 0 || conv > 15)
		{
			return false;
		}
	}
	return true;
}

// ============================================================================
// Function:	HexConversion
// Description:	Converts a Hex char to an integer
// Parameter:	c [IN] - Hex char to be converted to an integer
// Return:		int that was converted
// ============================================================================

int HexConversion(char c)
{
	if(isalpha(c))
	{
		return int(c - 55);
	}
	else
	{
		return int(c - 48);
	}
}

// ============================================================================
// Function:	IntConversion
// Description:	Converts an integer to a Hex char
// Parameter:	i [IN] - Integer to be converted to Hex char
// Return:		char that was converted
// ============================================================================

char IntConversion(int i)
{
	if(i > 9)
	{
		return i + 55;
	}
	else
	{
		return i + 48;
	}
}