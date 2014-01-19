#ifndef NETWORK_FPP_
#define NETWORK_FPP_

#include <boost/network/protocol/http/tags.hpp>

namespace boost {
namespace network {
namespace http {

template <class Tag, unsigned version_major, unsigned version_minor>
struct basic_client;

#ifndef BOOST_NETWORK_HTTP_CLIENT_DEFAULT_TAG
#define BOOST_NETWORK_HTTP_CLIENT_DEFAULT_TAG tags::http_async_8bit_udp_resolve
#endif

typedef basic_client<BOOST_NETWORK_HTTP_CLIENT_DEFAULT_TAG, 1, 1> client;

} // namespace http
} // namespace network
} // namespace boost

#endif // NETWORK_FPP_
