// ============================================================================
// File: CSimpleList.h -- linked list version, with exceptions (Spring 2013)
// ============================================================================
// This is the header file for the list ADT "CSimpleList".  This object
// supports the storage of "ListItemType" items using zero-based indexing. A
// linked list is used to store the items. The CListEx class is used to support
// exception handling.
// ============================================================================

#ifndef CSIMPLELIST_H
#define CSIMPLELIST_H

// the type of items being stored in the list
typedef int     ListItemType;



// linked list structure
struct  LNode
{
    ListItemType    item;
    LNode           *next;
};



// enumerated list for the exception class
enum    ListExType { LIST_EMPTY, LIST_FULL, INVALID_INDEX };



// exception class for CSimpleList
class   CListEx
{
public:
    CListEx(ListExType  exType) : m_exType(exType) {}
    ListExType  GetExType(void) const { return  m_exType; }

private:
    ListExType      m_exType;
};



// class declaration
class   CSimpleList
{
public:
    // constructors
    CSimpleList(void) : m_headPtr(NULL), m_numItems(0) {}
    CSimpleList(const CSimpleList  &object);
    ~CSimpleList(void) { DestroyList(); }

    // other member functions
    void    CreateList(void) { DestroyList(); }
    int     DestroyList(void);
    void    GetListItem(int  index, ListItemType  &item) const;
    int     GetNumItems(void) const { return m_numItems; }
    void    InsertItem(int  index, const ListItemType  &newItem);
    bool    IsListEmpty(void) const { return (NULL == m_headPtr); }
    bool    IsListFull(void) const { return false; }
    void    RemoveItem(int  index);

    // overloaded operators
    CSimpleList&    operator=(const CSimpleList  &rhs);

private:
    // data members
    LNode*  m_headPtr;
    int     m_numItems;

    // member functions
    int     CopyList(const CSimpleList  &otherList);
    LNode*  GetNodePtr(int  index) const;
};

#endif  // CSIMPLELIST_H

