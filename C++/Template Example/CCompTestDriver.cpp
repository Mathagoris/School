// ============================================================================
// File: main.cpp (Spring 2013)
// ============================================================================
// This program demonstrates the use of a non-member template function, and a
// template class.  The template function is exercised with calls using both
// basic data types as well as instantiations of the template class.
// ============================================================================

#include    <iostream>
#include    "CComp.h"
using namespace std;


template <typename  CompType>
int     CompValues(CompType  &valOne, CompType  &valTwo);


// ==== main ==================================================================
//
// ============================================================================

int     main(void)
{
    auto    int                 result;

    // test the function with basic chars
    auto    char                charOne;
    auto    char                charTwo;
    cout << "Enter the first basic character: ";
    cin >> charOne;
    cout << "Enter the second basic character: ";
    cin >> charTwo;
    result = CompValues(charOne, charTwo);
    if (result < 0)
        {
        cout << "The lesser basic character is: " << charOne << endl;
        }
    else if (result > 0)
        {
        cout << "The lesser basic character is: " << charTwo << endl;
        }
    else
        {
        cout << "The basic characters are equal\n";
        }

    // test the function with basic doubles
    auto    double              doubleOne;
    auto    double              doubleTwo;
    cout << "Enter the first basic double: ";
    cin >> doubleOne;
    cout << "Enter the second basic double: ";
    cin >> doubleTwo;
    result = CompValues(doubleOne, doubleTwo);
    if (result < 0)
        {
        cout << "The lesser basic double is: " << doubleOne << endl;
        }
    else if (result > 0)
        {
        cout << "The lesser basic double is: " << doubleTwo << endl;
        }
    else
        {
        cout << "The basic doubles are equal\n";
        }


    // test the function with character objects
    auto    CComp<char>    charObj1;
    auto    CComp<char>    charObj2;
    cout << "Enter the first template character value: ";
    cin >> charObj1;
    cout << "Enter the second template character value: ";
    cin >> charObj2;
    result = CompValues(charObj1, charObj2);
    if (result < 0)
        {
        cout << "The lesser character template is: " << charObj1 << endl;
        }
    else if (result > 0)
        {
        cout << "The lesser character template is: " << charObj2 << endl;
        }
    else
        {
        cout << "The character templates are equal\n";
        }

    // test the function with double objects
    auto    CComp<double>  doubleObj1;
    auto    CComp<double>  doubleObj2;
    cout << "Enter the first template double value: ";
    cin >> doubleObj1;
    cout << "Enter the second template double value: ";
    cin >> doubleObj2;
    result = CompValues(doubleObj1, doubleObj2);
    if (result < 0)
        {
        cout << "The lesser double template is: " << doubleObj1 << endl;
        }
    else if (result > 0)
        {
        cout << "The lesser double template is: " << doubleObj2 << endl;
        }
    else
        {
        cout << "The double templates are equal\n";
        }

    return  0;

}  // end of "main"


// ==== CompValues ============================================================
//
// This template function compares the two formal parameters using relational
// operators.
//
// Input:
//      valOne      -- a reference to the first object
//
//      valTwo      -- a reference to the second object
//
// Output:
//      If the first object is less than the second object, a value of -1 is
//      returned; if the second object is less than the first object, a value
//      of 1 is returned; if the objects are equal, a value of 0 is returned.
//
// ============================================================================

template <typename  Type>
int     CompValues(Type  &valOne, Type  &valTwo)
{
    if (valOne < valTwo)
        {
        return -1;
        }
    else if (valOne > valTwo)
        {
        return 1;
        }
    else
        {
        return 0;
        }

}  // end of "CompValues"

