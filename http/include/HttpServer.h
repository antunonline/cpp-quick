//
// Created by ahorvat on 31.03.19..
//

#ifndef TEMPLATE_HTTP_H
#define TEMPLATE_HTTP_H

#include <vector>
#include <string>
#include <unordered_map>
#include <functional>
#include <boost/beast/core.hpp>
#include <boost/beast/http.hpp>
#include <boost/beast/version.hpp>
#include <boost/asio/ip/tcp.hpp>
#include <boost/config.hpp>


namespace temp {
    namespace http::server {
        using std::vector;
        using std::unordered_map;
        using std::string;
        using boost::asio::io_context;

        using Headers = unordered_map<string, string>;
        using Body = vector<char>;

        class Request;
        class Response;
        using RequestHandler = std::function<Response (const Request &) >;

        using HandlerMap = unordered_map<string, RequestHandler>;

        class Request {
            string m_uri;
            string m_method;
            Headers m_headers;
        public:
            template<typename Uri, typename Method, typename Headers>
            Request(Uri &&uri, Method &&method, Headers &&headers) :
                    m_uri{std::forward<Uri>(uri)}, m_method{std::forward<Method>(method)}, m_headers{std::forward<Headers>(headers)} {}

            const string &uri() const &;

            const string &method() const &;

            const Headers &headers() const &;
        };

        class Response {
            int m_statusCode;
            vector<char> m_responseBody;
            unordered_map<string, string> m_headers;

        public:
            template<typename Body, typename Headers>
            Response(int statusCode, Body &&body, Headers &&headers) :
                    m_statusCode{statusCode}, m_responseBody{std::forward<Body>(body)}, m_headers{std::forward<Headers>(headers)} {}

            int statusCode() const;

            const Body &responseBody() const &;

            const Headers &headers() const &;
        };

        class HttpServer {
            io_context &m_ioContext;
            HandlerMap m_handlers;
            string listenAddr = "127.0.0.1";
            string listenPort = "8888";

            boost::asio::ip::tcp::acceptor m_acceptor;

            void socket_handler(boost::asio::ip::tcp::socket & socket) & ;

            void accept_handler(boost::system::error_code ec, boost::asio::ip::tcp::socket & sock) &;

        public:
            explicit HttpServer(io_context & service);
            bool addhandler(const string & path, const RequestHandler & handler) &;
            bool removeHandler(const string & path) &;
            void run() &;
        };
    }
}


#endif //TEMPLATE_HTTP_H
