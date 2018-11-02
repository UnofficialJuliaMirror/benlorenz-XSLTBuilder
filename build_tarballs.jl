using BinaryBuilder

version = v"1.1.32"

sources = [
    "ftp://xmlsoft.org/libxslt/libxslt-$(version).tar.gz" =>
        "526ecd0abaf4a7789041622c3950c0e7f2c4c8835471515fd77eec684a355460",
]

script = raw"""
cd ${WORKSPACE}/srcdir/libxslt-*
./configure --prefix=${prefix} --host=${target} --without-python
make -j${nproc} install
"""

products(prefix) = [
    LibraryProduct(prefix, "libxslt", :libxslt)
    LibraryProduct(prefix, "libexslt", :libexslt)
]

platforms = [
    Linux(:x86_64, libc=:glibc)
]
#platforms = supported_platforms()

dependencies = [
    "https://github.com/bicycle1885/ZlibBuilder/releases/download/v1.0.1/build_Zlib.v1.2.11.jl",
    "https://github.com/bicycle1885/XML2Builder/releases/download/v1.0.1/build_XML2Builder.v2.9.7.jl",
]

build_tarballs(ARGS, "XSLTBuilder", version, sources, script, platforms, products, dependencies)
