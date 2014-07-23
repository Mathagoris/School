#include <iostream>
using namespace std;

#include "CPet.h"

class   CDog : public CPet
{
public:
    CDog(const char *name) : CPet(name) {}

    virtual void    Eat(void) {cout << "I'm eating dog food!\n";
                               ++m_feedCount;}
    virtual void    Sleep(void) {cout << "Sleep, sleep sleep. Go to sleep.\n";
                               ++m_sleepCount;}
}
