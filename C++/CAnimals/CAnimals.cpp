// ============================================================================
// File: main.cpp (Spring 2013)
// ============================================================================
// This program is a simple exercise in inheritance and virtual functions. It
// assumes that the various types of inheritance haven't been introduced yet,
// so all data and functions are public in the class hierarchy to avoid issues.
//
// A base class CPet is used to store information about a generic animal:
// its name, and the number of meals and naps it has taken. Derived from
// CPet are CDog and CCat. These derived types override some of the
// inherited virtual functions, and add some specialized functions of their
// own.
//
// --------------------
// Here's a sample run:
// --------------------
//
//      <* Let's feed the animals! *>
//      Generic Pet: I'm eating generic pet food!
//      Rover: I'm eating dog food!
//      Simon: I'm eating cat food!
//
//      <* Dogs are always hungry, right? *>
//      Rover: I'm eating dog food!
//      Rover: I'm eating dog food!
//      Rover: I'm eating dog food!
//
//      <* How about a couple of generic pet naps? *>
//      Generic Pet: CPet sleeping generically...
//      Generic Pet: CPet sleeping generically...
//
//      <* How's the generic pet? *>
//      Generic Pet: So far I have had 1 meal and 2 naps!
//
//      <* Now let's see how the dog is doing... *>
//      Rover: So far I have had 4 meals and 0 naps!
//
//      <* The cat looks sleepy... *>
//      Simon: Time for a long cat nap...
//
//
//      <* I wonder how that cat is doing now? *>
//      Simon: So far I have had 1 meal and 1 nap!
//
// ============================================================================

#include    <iostream>
using namespace std;

#include    "CPet.h"
#include    "CDog.h"
#include    "CCat.h"


// function prototypes
void    FeedPet(CPet  &petParam);
void    PutToSleep(CPet  &petParam);
void    QueryPet(const CPet  &petParam);



// ==== main ==================================================================
//
// ============================================================================

int     main(void)
{
    auto    CPet        aPet("Generic Pet");
    auto    CDog        myDog("Rover");
    auto    CCat        myCat("Simon");

    // feed each animal once
    cout << "<* Let's feed the pets! *>" << endl;
    FeedPet(aPet);
    FeedPet(myDog);
    FeedPet(myCat);
    cout << endl;

    // feed the dog three more times
    cout << "<* Dogs are always hungry, right? *>" << endl;
    FeedPet(myDog);
    FeedPet(myDog);
    FeedPet(myDog);
    cout << endl;

    // put the generic pet down for a couple of naps
    cout << "<* How about a couple of generic pet naps? *>" << endl;
    PutToSleep(aPet);
    PutToSleep(aPet);
    cout << endl;

    // query the generic pet
    cout << "<* How's the generic pet? *>" << endl;
    QueryPet(aPet);
    cout << endl;

    // see how the dog's doing
    cout << "<* Now let's see how the dog is doing... *>" << endl;
    QueryPet(myDog);
    cout << endl;

    // let the cat take a long nap
    cout << "<* The cat looks sleepy... *>" << endl;
    PutToSleep(myCat);
    cout << endl;

    // see how the cat's doing
    cout << "<* I wonder how that cat is doing now? *>" << endl;
    QueryPet(myCat);
    cout << endl;

    return  0;

}  // end of "main"

// ==== FeedPet ===============================================================
//
// This function feeds a CPet object. It first has the pet announce itself so
// its name appears on stdout, then it lets the pet eat.
//
// Input:
//      petParam [IN/OUT]       -- a reference to a CPet object
//
// Output:
//      Nothing
//
// ============================================================================

void    FeedPet(CPet  &petParam)
{
    petParam.SayName();
    petParam.Eat();

}  // end of "FeedPet"



// ==== QueryPet ==============================================================
//
// This function has a pet display a summary of its current state (e.g., how
// many naps and meals the pet has had). First the pet announces itself so its
// name appears on stdout, then the pet displays its state.
//
// Input:
//      petParam [IN]           -- a const reference to a CPet object
//
// Output:
//      Nothing
//
// ============================================================================

void    QueryPet(const CPet  &petParam)
{
    petParam.SayName();
    petParam.DispState();

}  // end of "QueryPet"



// ==== PutToSleep ============================================================
//
// This function puts a pet to sleep (figuratively) by having it take a nap.
// It first has the pet announce itself so its name appears on stdout, then it
// lets the pet sleep.
//
// Input:
//      petParam [IN/OUT]       -- a reference to a CPet object
//
// Output:
//      Nothing
//
// ============================================================================

void    PutToSleep(CPet  &petParam)
{
    petParam.SayName();
    petParam.Sleep();

}  // end of "PutToSleep"

