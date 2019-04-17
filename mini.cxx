#include "mini.hxx"
#include <iostream>

#include <openturns/PersistentCollection.hxx>
#include <openturns/Distribution.hxx>


static OT::String fakeVar =
OT::PersistentCollection<OT::PersistentCollection<OT::Sample> >::GetClassName();

extern "C"
void ministring()
{
  std::cout << fakeVar << std::endl;
}
