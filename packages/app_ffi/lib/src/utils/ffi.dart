import 'dart:ffi' as ffi;

/// Forces casting a [ffi.Pointer] to a different type.
///
/// Unlike [ffi.Pointer.cast], the output type does not have to be a subclass of
/// the input type. This is especially useful for with [ffi.Pointer<Void>].
ffi.Pointer<T> cast<T extends ffi.NativeType>(ffi.Pointer<ffi.NativeType> ptr) =>
    ffi.Pointer<T>.fromAddress(ptr.address);

/// Checks if a [ffi.Pointer] is not null.
bool isNotNull(ffi.Pointer<dynamic> ptr) => ptr.address != ffi.nullptr.address;

