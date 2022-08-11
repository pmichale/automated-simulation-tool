#include "pend_viscous_p1p2_M2019b_capi_host.h"
static pend_viscous_p1p2_M2019b_host_DataMapInfo_T root;
static int initialized = 0;
__declspec( dllexport ) rtwCAPI_ModelMappingInfo *getRootMappingInfo()
{
    if (initialized == 0) {
        initialized = 1;
        pend_viscous_p1p2_M2019b_host_InitializeDataMapInfo(&(root), "pend_viscous_p1p2_M2019b");
    }
    return &root.mmi;
}

rtwCAPI_ModelMappingInfo *mexFunction() {return(getRootMappingInfo());}
