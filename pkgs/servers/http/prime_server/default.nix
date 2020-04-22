{ stdenv, fetchgit, autoconf, automake, libtool, czmq, zeromq, curl, pkgconfig }:

stdenv.mkDerivation rec {
  pname = "prime_server";
  name = "${pname}-${version}";
  version = "0.6.5";
  prePatch = "patchShebangs .";
  preConfigure = "./autogen.sh --prefix=$out";
  buildInputs = [ autoconf automake libtool czmq zeromq curl pkgconfig];
  src = fetchgit {
    url = "https://github.com/kevinkreiser/prime_server.git";
    rev = version;
    sha256 = "1yhxqlx9q7hmfjm5wcra8aqn0nq8n84kb750czcwk33djnyjmx68";
  };
  meta = with stdenv.lib; {
    description = "non-blocking (web)server API for distributed computing and SOA based on zeromq";
    homepage = "https://github.com/kevinkreiser/prime_server";
    licence = licenses.bsd2; 
  };
}
