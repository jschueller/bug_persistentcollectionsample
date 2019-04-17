#include <iostream>
#include <dlfcn.h>

#include <openturns/OT.hxx>

// #include <openturns/PersistentObjectFactory.hxx>
// 
// static OT::Factory<OT::PersistentCollection<OT::PersistentCollection<OT::Sample > > > Factory_CollectionCollectionSample;


typedef void (*minicall)();




int main(int argc, char *argv[])
{
  std::cout << "ns1="<<OT::Normal().getRealization()<<std::endl;

  void *hlib = dlopen("libmini.so", RTLD_LAZY | RTLD_GLOBAL);
  if(nullptr == hlib)
  {
    std::cout << "dlopen failed:" << dlerror() << std::endl;
    dlclose(hlib);
    return 1;
  }
  dlerror();
  void * hfunc = dlsym(hlib, "ministring");
  if(nullptr == hfunc)
  {
    std::cout << "dlsym failed:" << dlerror() << std::endl;
    dlclose(hlib);
    return 1;
  }
  minicall ministring = (minicall)hfunc;
  ministring();
  dlclose(hlib);
  return 0;
}
