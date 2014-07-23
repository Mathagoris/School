// ============================================================================
// File: hash_table.h
// ============================================================================
// Header file for the CHashTable class.
// ============================================================================

#ifndef CHASH_TABLE_H
#define CHASH_TABLE_H

#include <iostream>
#include <cstdlib>
#include "hashdefs.h"


// can easily use other basic types here
typedef     int     TableItemType;


// Hash table is an array of this struct
struct Cell
{
    TableItemType   value;
    int             status; // 0 if empty, 1 if occupied, -1 if deleted
};


class CHashTable
{
public:
    //ctors and dtors
    CHashTable();
    CHashTable(const CHashTable &table);
    virtual ~CHashTable() {}

    //member functions
    virtual bool IsTableEmpty() {return (0 == m_size);}
    virtual bool IsTableFull() {return (HASH_TABLE_SIZE == m_size);}
    virtual int TableSize() {return m_size;}
    virtual void DispTable();
    virtual int GetTableLength() {return m_size;}
    virtual int TableInsert(const TableItemType &newItem);
    virtual bool TableDelete(int searchKey);
    virtual bool TableRetrieve(int searchKey, TableItemType &tableItem);


protected:
    int HashOne(TableItemType searchKey) const
        {return abs(searchKey % HASH_TABLE_SIZE);}
    int HashTwo(TableItemType searchKey) const
        {return (m_prime - abs(searchKey % m_prime));}

private:
    // data members
    Cell    m_arr[HASH_TABLE_SIZE];
    int     m_size;
    int     m_prime;
};

#endif  // CHASH_TABLE_H

