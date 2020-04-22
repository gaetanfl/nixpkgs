{ stdenv, fetchgit, fetchpatch, libtool, pkgconfig, cmake, zlib, curl, protobuf, boost, sqlite, libspatialite, lua, python37, geos, zeromq, prime_server}:

let
  boostWithPython = boost.override { python = python37; enablePython = true; }; 
in
stdenv.mkDerivation rec {
  pname = "valhalla";
  name = "${pname}-${version}";
  version = "3.0.9";
  prePatch = "patchShebangs .";
  patches = [
    (fetchpatch{
        name = "geos_3.8.patch";
        url = "https://github.com/valhalla/valhalla/commit/266582a5c835519dfbc07d6dc355eb97e36ca987.patch";
        sha256 = "0nl45g4gqnl034r28yh7l11qhqv0wayy2r3hwn72vzpvvzbjz01r";
        excludes = [ "CHANGELOG.md" ];
      })
  ];
  cmakeFlags = [
    "-DENABLE_PYTHON_BINDINGS=ON"
    "-DENABLE_NODE_BINDINGS=OFF"
  ];
  buildInputs = [ cmake pkgconfig zlib curl protobuf prime_server boostWithPython sqlite libspatialite lua zeromq geos python37 ];
  src = fetchgit {
    url = "https://github.com/valhalla/valhalla.git";
    rev = version;
    sha256 = "0bsljpyfiy787xqzac5zqxc5p1rmwkq3dl6k2bckb2zqnaq3jc09";
  };
  meta = with stdenv.libs; {
    description = "Open Source Routing Engine for OpenStreetMap";
    homepage = "https://github.com/valhalla/valhalla";
    licence = licences.mit;
  };
}
