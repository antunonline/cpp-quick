//
// Created by ahorvat on 31.03.19..
//

#include "../include/HttpClient.h"
#include "folly/Uri.h"


namespace temp::http::client {
    using folly::Uri;

    HttpClient::HttpClient(asio::io_context &ioContext) : m_ioContext{ioContext}{

    }

    Response HttpClient::doGet(const string &addr) &{
        Uri uri{addr};
        uri.hostname();
        uri.port();

    }

    const int Response::responseCode() const &{
        return m_responseCode;
    }

    const Headers &Response::headers() const &{
        return m_headers;
    }

    const Body &Response::body() const &{
        return m_body;
    }
}