// ============================================================================
// File: CQueue.h (Spring 2013)
// ============================================================================
// Header file for the CQueue class.
// ============================================================================

#ifndef CQUEUE_H
#define CQUEUE_H

#include    "CSimpleList.h"

// type definitions
typedef ListItemType    QueueItemType;   // can use other basic types here

// enumerated list for the exception class
enum    QueueExType { QUEUE_EMPTY, QUEUE_FULL, QUEUE_ERROR };

// exception class for CQueue
class   CQueueEx
{
public:
    CQueueEx(QueueExType  exType) : m_exType(exType) {}
    QueueExType  GetExType(void) const { return  m_exType; }

private:
    QueueExType      m_exType;
};

class   CQueue
{
public:
    // constructors and destructor
    CQueue(void) {}
    CQueue(const CQueue  &object);
    ~CQueue(void) {}

    // member functions
    void    CreateQueue(void);
    int     DestroyQueue(void);
    void    Dequeue(void);
    void    Dequeue(QueueItemType  &newItem);
    void    Enqueue(const QueueItemType  &newItem);
    void    Retrieve(QueueItemType  &frontItem) const;
    bool    IsQueueEmpty(void) const { return (m_list.IsListEmpty()); }

    // overloaded operators
    CQueue& operator=(const CQueue  &rhs);

private:
    // data members
    CSimpleList m_list;
};

#endif  // CQUEUE_H
