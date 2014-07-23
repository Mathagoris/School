#include <iostream>
using namespace std;
#include "CQueue.h"

CQueue::CQueue(const CQueue &object)
{
    m_list = object.m_list;
}

void    CQueue::CreateQueue(void)
{
    m_list.CreateList();
}

int     CQueue::DestroyQueue(void)
{
    return m_list.DestroyList();
}

void    CQueue::Dequeue(void)
{
    try {
        m_list.RemoveItem(m_list.GetNumItems() - 1);
        }
    catch (const CListEx &listEx)
        {
        if (LIST_EMPTY == listEx.GetExType())
            {
            throw CQueueEx(QUEUE_EMPTY);
            }
        else
            {
            throw CQueueEx(QUEUE_ERROR);
            }
        }
}

void    CQueue::Dequeue(QueueItemType &newItem)
{
    try {
 Retrieve(newItem);
        Dequeue();
        }
    catch (const CQueue &queueEx)
        {
        throw;
        }
}

void    CQueue::Retrieve(QueueItemType &frontItem)const
{
    try {
        m_list.GetListItem(m_list.GetNumItems() - 1, frontItem);
        }
    catch (const CListEx &listEx)
        {
        if (LIST_EMPTY == listEx.GetExType())
            {
            throw CQueueEx(QUEUE_EMPTY);
            }
        else
            {
            throw CQueueEx(QUEUE_ERROR);
            }
        }
}


void    CQueue::Enqueue(const QueueItemType  &newItem)
{
    try {
        m_list.InsertItem(0, newItem);
        }
    catch (const CListEx &listEx)
        {
        throw CQueueEx(QUEUE_ERROR);
        }
}

CQueue&     CQueue::operator=(const CQueue &rhs)
{
    m_list = rhs.m_list;
    return *this;
}


