#include <iostream>
#include <cstdlib>
using namespace std;

#include "CPet.h"

class   CCat : public CPet
{
public:
    CCat(const char *name) : CPet(name) {}

    virtual void    Eat(void) {cout << "I'm eating cat food!\n";
                               ++m_feedCount;}
    virtual void    Sleep(void) {cout << "Time for a long nap...\n";
                                 ++m_sleepCount;}
}

