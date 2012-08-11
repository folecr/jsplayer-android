#ifndef __SPIDERMONKEY_BINDINGS__
#define __SPIDERMONKEY_BINDINGS__ 

namespace spidermonkeybindings {
    const char* getBindingsVersion(void);
    void bindingsDiagnostics(void);
    int runJS(char* script);
}

#endif // __SPIDERMONKEY_BINDINGS__
