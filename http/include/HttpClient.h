//
// Created by ahorvat on 31.03.19..
//

#ifndef TEMPLATE_HTTPCLIENT_H
#define TEMPLATE_HTTPCLIENT_H

#include "boost/asio.hpp"
#include "boost/beast/core.hpp"
#include "boost/beast/http.hpp"
#include <unordered_map>
#include <vector>

namespace temp::http::client {
    namespace asio = boost::asio;
    namespace beast = boost::beast;
    using std::string;
    using std::vector;


    using Headers = std::unordered_map<string, string>;
    using Body = vector<char>;


    class Response {
        int m_responseCode;
        Headers m_headers;
        Body m_body;

        template<typename Headers, typename Body>
        Response(int responseCode, Headers && headers, Body && body) :
        m_responseCode{responseCode}, m_headers{std::forward<Headers>(headers)},
        m_body{std::forward<Body>(body)}{}

        const int responseCode() const &;
        const Headers & headers() const &;
        const Body & body() const &;

    };

    class HttpClient {
        asio::io_context & m_ioContext;
    public:
        HttpClient(asio::io_context & ioContext);

        Response doGet(const string & addr) &;
    };
}


#endif //TEMPLATE_HTTPCLIENT_H
