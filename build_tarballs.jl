using BinaryBuilder

version = v"1.1.33"

sources = [
    "https://github.com/GNOME/libxslt/archive/v$(version).tar.gz" =>
        "cb4bca0adbabf218948550bdf1f1b20120e7ae8322c7d599be4b58908946aad8",
]

script = raw"""
cd ${WORKSPACE}/srcdir/libxslt-*
./autogen.sh
./configure --prefix=${prefix} --host=${target} --without-python
make -j${nproc} install
"""

products(prefix) = [
    LibraryProduct(prefix, "libxslt", :libxslt)
    LibraryProduct(prefix, "libexslt", :libexslt)
]

platforms = supported_platforms()

dependencies = [
    "https://github.com/bicycle1885/ZlibBuilder/releases/download/v1.0.4/build_Zlib.v1.2.11.jl",
    "https://github.com/bicycle1885/XML2Builder/releases/download/v1.0.2/build_XML2Builder.v2.9.9.jl"
]

build_tarballs(ARGS, "XSLTBuilder", version, sources, script, platforms, products, dependencies)
