// ============================================================================
// File: main.cpp (Spring 2013)
// ============================================================================
// This is the test driver for the CQueue ADT.  It creates a local queue object
// and allows the user to insert and remove items to and from the queue.
// ============================================================================

#include    <iostream>
using namespace std;
#include    <stdlib.h>
#include    <ctype.h>
#include    "CQueue.h"

// function prototypes
void    DisplayMenu(void);
void    FlushInstream(istream  &inStream = cin);


// ==== main ==================================================================
//
// ============================================================================

int     main(void)
{
    auto    bool                bLoop = true;
    auto    char                selection;
    auto    CQueue              myQueue;
    auto    int                 intVal;

    // let the user manipulate the list
    do  {
        DisplayMenu();

        // get the user selection
        cout << "\nPlease enter your selection: ";
        cin >> selection;

        // call the appropriate member function
        switch (toupper(selection))
            {
            case   'A':     // add an item to the queue
                cout << "Please enter a value to add to the queue: ";
                if (!(cin >> intVal))
                    {
                    cout << "Error reading int, please try again...\n";
                    FlushInstream();
                    continue;
                    }

                // add the new item to the queue
                try {
                    myQueue.Enqueue(intVal);
                    cout << intVal << " added to the queue" << endl;
                    }
                catch (const CQueueEx&)
                    {
                    cout << "Error inserting " << intVal << "..." << endl;
                    }
                break;

            case   'R':     // remove an item from the queue
                try {
                    myQueue.Dequeue(intVal);
                    cout << intVal << " removed from the queue" << endl;
                    }
                catch (const CQueueEx  &queueEx)
                    {
                    if (QUEUE_EMPTY == queueEx.GetExType())
                        {
                        cout << "Queue is already empty..." << endl;
                        }
                    else
                        {
                        cout << "Unable to dequeue an item..." << endl;
                        }
                    }
                break;

            case   'C':     // clear the queue of all items
                // loop and dequeue items until the queue is empty
                try {
                    intVal = myQueue.DestroyQueue();

                    // display a summarial message
                    cout << "There " << ((1 == intVal) ? "was " : "were ")
                                     << intVal
                                     << " item" << ((1 == intVal) ? "" : "s")
                                     << " removed from the queue\n";
                    }
                catch (const CQueueEx&)
                    {
                    cout << "Error dequeing an item... " << endl;
                    }

                break;

            case   'Q':     // quit the program
                bLoop = false;
                break;

            default:
                cout << "Unrecognized selection; please try again...\n\n";
                break;
            }

        cout << endl;

        } while (true == bLoop);


    auto  CQueue      queue2 = myQueue;

    return 0;

}  // end of "main"



// ==== DisplayMenu ===========================================================
//
// This function simply displays the list of menu options available to the
// user.
//
// Input:  nothing
// Output: nothing
//
// ============================================================================

void    DisplayMenu(void)
{
    cout << "A)dd an item to the queue\n";
    cout << "R)emove an item from the queue\n";
    cout << "C)lear the queue\n";
    cout << "Q)uit\n";

}  // end of "DisplayMenu"



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
    auto    char        inChar;

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
