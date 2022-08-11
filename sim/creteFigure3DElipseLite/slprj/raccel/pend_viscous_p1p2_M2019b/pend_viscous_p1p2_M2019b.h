#include "__cf_pend_viscous_p1p2_M2019b.h"
#ifndef RTW_HEADER_pend_viscous_p1p2_M2019b_h_
#define RTW_HEADER_pend_viscous_p1p2_M2019b_h_
#include <stddef.h>
#include <string.h>
#include "rtw_modelmap.h"
#ifndef pend_viscous_p1p2_M2019b_COMMON_INCLUDES_
#define pend_viscous_p1p2_M2019b_COMMON_INCLUDES_
#include <stdlib.h>
#include "rtwtypes.h"
#include "simtarget/slSimTgtSigstreamRTW.h"
#include "simtarget/slSimTgtSlioCoreRTW.h"
#include "simtarget/slSimTgtSlioClientsRTW.h"
#include "simtarget/slSimTgtSlioSdiRTW.h"
#include "sigstream_rtw.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "raccel.h"
#include "slsv_diagnostic_codegen_c_api.h"
#include "rt_logging.h"
#include "dt_info.h"
#include "ext_work.h"
#endif
#include "pend_viscous_p1p2_M2019b_types.h"
#include "multiword_types.h"
#include "mwmathutil.h"
#include "rt_defines.h"
#include "rtGetInf.h"
#include "rt_nonfinite.h"
#define MODEL_NAME pend_viscous_p1p2_M2019b
#define NSAMPLE_TIMES (2) 
#define NINPUTS (0)       
#define NOUTPUTS (1)     
#define NBLOCKIO (3) 
#define NUM_ZC_EVENTS (0) 
#ifndef NCSTATES
#define NCSTATES (2)   
#elif NCSTATES != 2
#error Invalid specification of NCSTATES defined in compiler command
#endif
#ifndef rtmGetDataMapInfo
#define rtmGetDataMapInfo(rtm) (*rt_dataMapInfoPtr)
#endif
#ifndef rtmSetDataMapInfo
#define rtmSetDataMapInfo(rtm, val) (rt_dataMapInfoPtr = &val)
#endif
#ifndef IN_RACCEL_MAIN
#endif
typedef struct { real_T f00vbnielh ; real_T dqk03e5fw5 ; real_T kzj3f53adv ;
} B ; typedef struct { struct { void * LoggedData ; } g2fxa2q14y ; } DW ;
typedef struct { real_T dxfd0tboxq ; real_T fb15smpikl ; } X ; typedef struct
{ real_T dxfd0tboxq ; real_T fb15smpikl ; } XDot ; typedef struct { boolean_T
dxfd0tboxq ; boolean_T fb15smpikl ; } XDis ; typedef struct { real_T
idsb125pkz ; } ExtY ; typedef struct { rtwCAPI_ModelMappingInfo mmi ; }
DataMapInfo ; struct P_ { real_T p1 ; real_T p2 ; real_T phi0 ; real_T
Integratorvel_IC ; } ; extern const char * RT_MEMORY_ALLOCATION_ERROR ;
extern B rtB ; extern X rtX ; extern DW rtDW ; extern ExtY rtY ; extern P rtP
; extern const rtwCAPI_ModelMappingStaticInfo *
pend_viscous_p1p2_M2019b_GetCAPIStaticMap ( void ) ; extern SimStruct * const
rtS ; extern const int_T gblNumToFiles ; extern const int_T gblNumFrFiles ;
extern const int_T gblNumFrWksBlocks ; extern rtInportTUtable *
gblInportTUtables ; extern const char * gblInportFileName ; extern const
int_T gblNumRootInportBlks ; extern const int_T gblNumModelInputs ; extern
const int_T gblInportDataTypeIdx [ ] ; extern const int_T gblInportDims [ ] ;
extern const int_T gblInportComplex [ ] ; extern const int_T
gblInportInterpoFlag [ ] ; extern const int_T gblInportContinuous [ ] ;
extern const int_T gblParameterTuningTid ; extern DataMapInfo *
rt_dataMapInfoPtr ; extern rtwCAPI_ModelMappingInfo * rt_modelMapInfoPtr ;
void MdlOutputs ( int_T tid ) ; void MdlOutputsParameterSampleTime ( int_T
tid ) ; void MdlUpdate ( int_T tid ) ; void MdlTerminate ( void ) ; void
MdlInitializeSizes ( void ) ; void MdlInitializeSampleTimes ( void ) ;
SimStruct * raccel_register_model ( void ) ;
#endif
