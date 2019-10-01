//
// Created by xinfeng on 2019-09-16.
//

#ifndef APP_FFI_H
#define APP_FFI_H

// FFI_EXTERN_C MACROS
#ifdef __cplusplus
#define FFI_EXTERN_C extern "C"
#else
#define FFI_EXTERN_C
#endif
// FFI_EXPORT MACROS
#if defined(__CYGWIN__)
#error Tool chain and platform not supported.
#elif defined(_WIN32)
#error Tool chain and platform not supported.
#elif  __GNUC__ >= 4
#define FFI_EXPORT FFI_EXTERN_C __attribute__((visibility("default"))) __attribute((used))
#else
#define FFI_EXPORT FFI_EXTERN_C
#endif

// api start line
FFI_EXPORT int add(int,int);



// api end line

#endif //APP_FFI_H
