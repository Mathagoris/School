// ============================================================================
// File: main.cpp
// ============================================================================
// Programmer: Matt Dohlen
// Date: 05/17/2013
// Class: CSCI 133 ("Data Structures")
// Time: MW 11:45am
// Instructor: Mr. Edwards
// Project: Hash Table
//
// Description:
//      This program takes integer arguments from the stream and attempts to
//      input the into a hash table. It displays a message letting the user
//      know if the insertion was successful, failed, or if the value trying
//      to be inserted was a duplicate.
//
// ============================================================================

#include    <iostream>
#include    <cstdlib>
#include    "hash_table.h"
using namespace std;



// ==== main ==================================================================
//
// ============================================================================

int    main(void)
{
    auto    TableItemType   inVal;
    auto    CHashTable      myTable;
    auto    int             insertResult;

    while (cin >> inVal)
        {
        insertResult = myTable.TableInsert(inVal);
        if (1 == insertResult)
            {
            cout << "Success: " << inVal << endl;   //"\t/" << "/ " << inVal
                 //<< " was successfully inserted into the table.\n";
            }
        else if (0 == insertResult)
            {
            cout << "Exists: " << inVal << endl;    //<< "\t/" << "/ " << inVal
                 //<< " already exists in the table\n";
            }
        else
            {
            cout << "Failure: " << inVal << endl;   //"\t/" << "/ " << inVal
                 //<< " cannot be inserted, no available location\n";
            }
        //cout << myTable.TableSize() << endl;
        }
    //myTable.DispTable();
    return 0;

}  // end of "main"
