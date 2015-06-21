# 1.58.0 issue https://svn.boost.org/trac/boost/ticket/11410
# 1.57.0-1.56.0 Doesn't work on Linux (GCC, c++11)
hunter_config(Boost VERSION 1.55.0-patched-3)
hunter_config(Sober VERSION ${HUNTER_Sober_VERSION} CMAKE_ARGS SOBER_RELAX_WARNINGS=ON)
