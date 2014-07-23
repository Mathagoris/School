// ============================================================================
// File: hash_table.cpp (Spring 2013)
// ============================================================================
// This is the implementation file for the list ADT "CSortedList".  This
// particular implementation uses a linked list to store a list of type
// "ListItemType" items.
// ============================================================================

#include    <iostream>
using namespace std;
#include    "hash_table.h"



// ==== CHashTable Default Constructor ========================================
//
// This is the default constructor for the CHashTable class. The status of all
// elements in the Cell array is set to zero (empty) and the size is also set
// to zero.
//
// Input:
//      nothing
//
// Output:
//      nothing
//
// ============================================================================

CHashTable::CHashTable(void)
{
    auto    int     index;

    for (index = 0; index < HASH_TABLE_SIZE; ++index)
        {
        m_arr[index].status = 0;
        m_arr[index].value = 0;
        }
    m_size = 0;
    for (index = 0; ; ++index)
        {
        if (((index * index) + index + 41) < HASH_TABLE_SIZE)
            {
            m_prime = (index * index) + index + 41;
            }
        else
            {
            break;
            }
        }

}   // end of "CHashTable::CHashTable"



// ==== CHashTable Default Constructor ========================================
//
// This is the copy constructor for the CHashTable class. The status and value
// of all elements in the Cell array as well as the size of the table of the
// calling object are set to the other objects values.
//
// Input:
//      table [OUT]     --  hash table whose value is to be copied over to the
//                          calling object.
//
// Output:
//      nothing
//
// ============================================================================

CHashTable::CHashTable(const CHashTable &table)
{
    auto    int     index;

    for (index = 0; index < HASH_TABLE_SIZE; ++index)
        {
        m_arr[index].value = table.m_arr[index].value;
        m_arr[index].status = table.m_arr[index].status;
        }
    m_size = table.m_size;
    m_prime = table.m_prime;

}   // end of "CHashTable::CHashTable"



// ==== CHashTable::TableInsert ===============================================
//
// This function attempts to insert a new item into the hash table. It fails
// if the list is full or the collision cannot be resolved. It also will not
// insert a duplicate item into the table. Otherwise it is successful
//
// Input:
//      newItem [IN]    -- new item to be inserted
//
// Output:
//      Returns an integer that indicates whether the insertion failed, the
//      item was a duplicate or the insertion was successful.
//
// ============================================================================



int     CHashTable::TableInsert(const TableItemType &newItem)
{
    auto    int     hashIndex = HashOne(newItem);
    auto    int     dHashIndex;
    auto    int     i;

    if (IsTableFull())
        {
        return -1;
        }
    else if (m_arr[hashIndex].status == 0 || m_arr[hashIndex].status == -1)
        {
        m_arr[hashIndex].value = newItem;
        ++m_size;
        m_arr[hashIndex].status = 1;
        return 1;
        }
    else if (m_arr[hashIndex].value == newItem)
        {
        return 0;
        }
    else
        {
        for (i = 1; ; ++i)
            {
            dHashIndex = HashOne(hashIndex + HashTwo(newItem) * i);
            if (hashIndex == dHashIndex)
                {
                return -1;
                }
            else if (m_arr[dHashIndex].status == 0 ||
                     m_arr[dHashIndex].status == -1)
                {
                m_arr[dHashIndex].value = newItem;
                ++m_size;
                m_arr[dHashIndex].status = 1;
                return 1;
                }
            else if (m_arr[dHashIndex].value == newItem)
                {
                return 0;
                }
            }
        }

}   // end of "CHashTable::TableInsert"



// ==== CHashTable::TableDelete ===============================================
//
// This function attempts to delete an item from the hash table. If the hash
// function of the search key and the hash function of the value of the
// element at the index of the afformentioned hash function of the search key.
// ie. HashFunc(SK) == HashFunc(m_arr[HashFunc(SK)].value) then the proper
// value has been found. If the proper value is not found on the first hash
// the process is repeated for double hashing.
//
// Input:
//      searchKey [IN]  -- search key used to delete from the table
//
// Output:
//      return true if item was delete and false if not
//
// ============================================================================



bool    CHashTable::TableDelete(int searchKey)
{
    auto    int     hashIndex = HashOne(searchKey);
    auto    int     dHashIndex;
    auto    int     i;

    if (m_arr[hashIndex].status != 1)
        {
        return false;
        }
    else if (hashIndex == HashOne(m_arr[hashIndex].value))
        {
        m_arr[hashIndex].status = -1;
        --m_size;
        return true;
        }
    else
        {
        for (i = 1; ; ++i)
            {
            dHashIndex = HashOne(hashIndex + HashTwo(searchKey) * i);
            if (hashIndex == dHashIndex || m_arr[dHashIndex].status != 1)
                {
                return false;
                }
            if (dHashIndex == (HashOne(HashOne(m_arr[hashIndex].value)
                              + HashTwo(m_arr[hashIndex].value) * i)))
                {
                m_arr[dHashIndex].status = -1;
                --m_size;
                return true;
                }
            }
        }

}   // end of "CHashTable::TableDelete"



// ==== CHashTable::TableRetrieve =============================================
//
// This function attempts to retrieve an item from the hash table. If the hash
// function of the search key and the hash function of the value of the
// element at the index of the afformentioned hash function of the search key.
// ie. HashFunc(SK) == HashFunc(m_arr[HashFunc(SK)].value) then the proper
// value has been found. If the proper value is not found on the first hash
// the process is repeated for double hashing.
//
// Input:
//      searchKey [IN]  -- search key used to retrieve from the table
//      tableItem [OUT] -- pass by reference used to store value if it is
//                         retrieved
//
// Output:
//      return true if item was retrieved and false if not
//
// ============================================================================


bool    CHashTable::TableRetrieve(int searchKey, TableItemType &tableItem)
{
    auto    int     hashIndex = HashOne(searchKey);
    auto    int     dHashIndex;
    auto    int     i;

    if (m_arr[hashIndex].status != 1)
        {
        return false;
        }
    else if (hashIndex == HashOne(m_arr[hashIndex].value))
        {
        tableItem = m_arr[hashIndex].value;
        return true;
        }
    else
        {
        for (i = 1; ; ++i)
            {
            dHashIndex = HashOne(hashIndex + HashTwo(searchKey) * i);
            if (hashIndex == dHashIndex || m_arr[dHashIndex].status != 1)
                {
                return false;
                }
            if (dHashIndex == (HashOne(HashOne(m_arr[hashIndex].value)
                              + HashTwo(m_arr[hashIndex].value) * i)))
                {
                tableItem = m_arr[dHashIndex].value;
                return true;
                }
            }
        }

}   // end of "CHashTable::TableRetrieve"



// ==== CHashTable::DispTable =================================================
//
// This function displays the contents of the hash table.
//
// Input:
//      nothing
//
// Output:
//      nothing
//
// ============================================================================



void    CHashTable::DispTable(void)
{
    auto    int     index;

    for (index = 0; index < HASH_TABLE_SIZE; ++index)
        {
        cout << m_arr[index].value << endl;
        }

}   // end of "CHashTable::DispTable"

