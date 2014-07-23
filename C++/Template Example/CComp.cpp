#include <iostream>
#include "CComp.h"
using namespace std;

template <typename CompType>
bool    CComp<CompType>::operator==(CComp<CompType>  &rhs) const
{
    if(m_data == rhs.m_data)
        {
        return true;
        }
    else
        {
        return false;
        }
}


template <typename CompType>
bool    CComp<CompType>:: operator< (CComp<CompType>  &rhs) const
{
    if(m_data < rhs.m_data)
        {
        return true;
        }
    else
        {
        return false;
        }
}


template <typename CompType>
bool    CComp<CompType>:: operator>(CComp<CompType>  &rhs) const
{
    if(m_data > rhs.m_data)
        {
        return true;
        }
    else
       {
        return false;
        }
}


template <typename CompType>
bool    CComp<CompType>::operator!=(CComp<CompType>  &rhs) const
{
    if(m_data != rhs.m_data)
        {
        return true;
        }
    else
        {
        return false;
        }
}

template <typename CompType>
istream&    operator>>(istream &inStream, CComp<CompType> &rhs)
{
    auto    CompType    streamVal;

    inStream >> streamVal;
    rhs.SetData(streamVal);
    return inStream
}

template <typename CompType>
istream&    operator<<(ostream &outStream, CComp<CompType> &rhs)
{
    outStream << rhs.GetData();
    return outStream;
}
