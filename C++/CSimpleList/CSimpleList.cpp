#include    <iostream>
using namespace std;
#include    "CSimpleList.h"



LNode*  CSimpleList::GetNodePtr(int  index) const
{
    if (index > (m_numItems - 1) || index < 0)
        {
        throw CListEx(INVALID_INDEX);
        }
    if (IsListEmpty())
        {
        throw CListEx(LIST_EMPTY);
        }

    auto    LNode*  listPtr = m_headPtr;
    auto    int     counter = 0;

    while (counter < index)
        {
        listPtr = listPtr->next;
        ++counter;
        }
    return listPtr;
}



void    CSimpleList::RemoveItem(int  index)
{
    auto    LNode*  listPtr = GetNodePtr(index);

    if (index == 0)
        {
        m_headPtr = listPtr->next;
        delete listPtr;
       --m_numItems;
        }
    else
        {
        auto    LNode* leadPtr = GetNodePtr(index - 1);

        leadPtr->next = leadPtr->next->next;
        delete listPtr;
        --m_numItems;
        }
}

void    CSimpleList::GetListItem(int  index, ListItemType  &item) const
{
    auto    LNode*  listPtr = GetNodePtr(index);

    item = listPtr->item;
}

void    CSimpleList::InsertItem(int  index, const ListItemType  &newItem)
{
    if (0 == index)
        {
        auto    LNode*  listPtr = new LNode;
        listPtr->next = m_headPtr;
        m_headPtr = listPtr;
        m_headPtr->item = newItem;
        ++m_numItems;
        return;
        }
    auto    LNode*  leadPtr;
    try {
        leadPtr = GetNodePtr(index - 1);
        }
    catch (const CListEx&  listEx)
        {
        if (INVALID_INDEX == listEx.GetExType())
            {
            throw;
            }
        }
    auto    LNode*  listPtr = new LNode;

    listPtr->next = leadPtr->next;
    leadPtr->next = listPtr;
    listPtr->item = newItem;
    ++m_numItems;
}


int     CSimpleList::DestroyList(void)
{
    auto    LNode*  listPtr = m_headPtr;
    auto    LNode*  leadPtr;

    m_headPtr = NULL;
    m_numItems = 0;
    while (listPtr != NULL)
        {
        leadPtr = listPtr->next;
        delete listPtr;
        listPtr = leadPtr;
        }
}


int     CSimpleList::CopyList(const CSimpleList  &otherList)
{
    auto    int     index = 0;
    auto    LNode*  listPtr;
    auto    LNode*  otherPtr = otherList.m_headPtr;
    auto    LNode*  newPtr;

    if (this != &otherList)
        {
        DestroyList();
        if (otherPtr == NULL)
            {
            return index;
            }
        listPtr = new LNode;
        m_headPtr = listPtr;
        m_headPtr->item = otherPtr->item;
        m_numItems = otherList.m_numItems;
        while (index < (m_numItems - 1))
            {
            newPtr = new LNode;
            listPtr->next = newPtr;
            listPtr = newPtr;
            listPtr->item = otherPtr->item;
            ++index;
            }
        listPtr->next = NULL;
        return index;
        }
}


CSimpleList&    CSimpleList::operator=(const CSimpleList  &rhs)
{
    if (this != &rhs)
        {
        CopyList(rhs);
        }
    return *this;
}


CSimpleList::CSimpleList(const CSimpleList &object)
{
    DestroyList();
    CopyList(object);
}

