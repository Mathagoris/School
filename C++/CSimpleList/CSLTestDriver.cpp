// ============================================================================
// File: main.cpp (Spring 2013)
// ============================================================================
// This is a driver program to test the CSimpleList ADT that throws exceptions.
// It just allows the user to manipulate the contents of the indexed list.
// Note that all index values requested of the user are zero-based.
// ============================================================================

#include    <iostream>
#include    <cstdlib>
#include    <cstdio>
#include    <cctype>
using namespace std;
#include    "CSimpleList.h"


// function prototypes
int     DisplayList(CSimpleList  &listObject);
void    DisplayMenu(void);
void    FlushInstream(istream  &inStream = cin);


// ==== main ==================================================================
//
// ============================================================================

int     main(void)
{
    bool            bLoop = true;
    char            selection;
    int             index;
    int             intVal;
    CSimpleList     list;

    // allow the user to manipulate the list
    do  {
 // display the main menu
        DisplayMenu();

        // get the user selection
        cout << "\nPlease enter your selection: ";
        cin >> selection;

        // call the appropriate member function
        switch (toupper(selection))
            {
            case  'A':
                // get a new integer value to insert
                cout << "Please enter a new value: ";
                if (!(cin >> intVal))
                    {
                    cout << "Error reading int, please try again...\n";
                    FlushInstream();
                    continue;
                    }

                // get an index
                cout << "Please enter a target index: ";
                if (!(cin >> index))
                    {
                    cout << "Error reading int, please try again...\n";
                    FlushInstream();
                    continue;
                    }

                // try to add the item to the list
                try {
                    list.InsertItem(index, intVal);
                    }
                catch (const CListEx&  listEx)
                    {
                    if (INVALID_INDEX == listEx.GetExType())
                        {
                        cout << "Sorry, invalid index...\n";
                        }
                    else if (LIST_FULL == listEx.GetExType())
                        {
                        cout << "Sorry, the list is currently full...\n";
                        }
                    else
                        {
                        cout << "Sorry, insertion failed...\n";
                        }
                    }
                break;

            case  'R':
                // get a target index from the user
                cout << "Please enter the index of the item to remove: ";
                if (!(cin >> index))
                    {
                    cout << "Error reading int, please try again...\n";
                    FlushInstream();
                    continue;
                    }

                // try to remove the item from the list
                try {
                    list.GetListItem(index, intVal);
                    list.RemoveItem(index);
                    cout << intVal << " was just removed from the list." << end$
                    }
                catch (const CListEx&  listEx)
                    {
                    if (INVALID_INDEX == listEx.GetExType())
                        {
                        cout << "Sorry, invalid index...\n";
                        }
                    else if (LIST_EMPTY == listEx.GetExType())
                        {
                        cout << "Sorry, the list is currently empty...\n";
                        }
                    else
                        {
                        cout << "Sorry, removal failed...\n";
                        }
                    }
                break;

            case  'D':
                // display the current contents of the list
                if (0 == DisplayList(list))
                    {
                    cout << "List is empty." << endl;
                    }
                break;

            case  'Q':
                bLoop = false;
                break;

            default:
                cout << "Unrecognized response; try again...\n";
                break;

            }  // end of switch

        } while (true == bLoop);

    return  0;

}  // end of "main"



// ==== DisplayMenu ===========================================================
//
// This function displays the menu selections to stdout.
//
// Input:
//      Nothing.
//
// Output:
//      Nothing.
//
// ============================================================================

void    DisplayMenu(void)
{
    cout << "\nDo you wish to:\n";
    cout << "  A)dd a new item to the list\n";
    cout << "  R)emove a new item from the list\n";
    cout << "  D)isplay the current contents of the list\n";
    cout << "  Q)uit the program\n";

}  // end of "DisplayMenu"



// ==== DisplayList ===========================================================
//
// This function displays the current contents of the CSimpleList object to
// stdout.
//
// Input:
//      listObject  -- a reference to a CSimpleList object
//
// Output:
//      The number of items written to stdout.
//
// ============================================================================

int     DisplayList(CSimpleList  &listObject)
{
    int             index;
    ListItemType    listItem;

    // loop and fetch values from the list, displaying each one to stdout
    for (index = 0; index < listObject.GetNumItems(); ++index)
        {
        try   {
              listObject.GetListItem(index, listItem);
              cout << listItem << endl;
              }
        catch (const CListEx&)
              {
              cout << "DisplayList: unable to fetch item at index " << index
                                                                    << endl;
              }
        }

    return (index);

}  // end of "DisplayList"



// ==== FlushInstream =========================================================
//
// This function displays the current contents of the list to the standard
// output stream.
//
// Input:
//      inStream    -- a reference to the input stream to flush
//
// Output:
//      Nothing.
//
// ============================================================================

void    FlushInstream(istream  &inStream)
{
    char        inChar;

    inStream.clear();
    while (false == inStream.eof())
        {
        inStream.get(inChar);
        if ('\n' == inChar)
            {
            break;
            }
        }

}  // end of "FlushInstream"

