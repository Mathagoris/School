#ifndef CCOMP_HEADER
#define CCOMP_HEADER

#include <iostream>
#include "main.cpp"

template <typename  CompType>
class   CComp
{
public:
    // overloaded operators
    bool    operator==(CComp  &rhs) const;
    bool    operator<(CComp  &rhs) const;
    bool    operator>(CComp  &rhs) const;
    bool    operator!=(CComp  &rhs) const;

    // accessor functions
    CompType    GetData(void) const { return  m_data; }
    void        SetData(const CompType  &newData) { m_data = newData; }

private:
    CompType    m_data;
};

template <typename CompType>
istream& operator>>(istream &inStream, CComp<CompType> &rhs);
template <typename CompType>
ostream& operator<<(ostream &outStream, CComp<CompType> &rhs);

#include "CComp.cpp"
#endif
