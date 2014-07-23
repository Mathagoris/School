#ifndef CPET_H
#define CPET_H

#include <iostream>
#include <cstdlib>
using namespace std;

#include "CDog.h"
#include "CCat.h"

#define BUFLEN  256

class   CPet
{
public:
    //Ctors
    CPet(const char *name) {m_feedCount = m_sleepCount = 0;
                            strcpy(m_name, name);}

    void    SayName(void) {int i; for (i = 0; i < strlen(m_name); ++i)
                          {cout << m_name[i];} cout << ": ";}
    void    DispState(void) {cout << "So far I have had " << m_feedCount
                << ((m_feedCount == 1) ? "meal" : "meals") << " and "
                << m_sleepCount << ((m_sleepCount == 1) ? "nap!\n" : "naps!\n");}
    virtual void    Eat(void) {cout << "I'm eating generic pet food!\n";
                ++m_feedCount;}
    virtual void    Sleep(void) {cout << "CPet is sleeping generically...\n";
                ++m_sleepCount;}

    char    m_name[BUFLEN];
    int     m_feedCount;
    int     m_sleepCount;
};

#endif

