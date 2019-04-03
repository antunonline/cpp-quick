//
// Created by ahorvat on 31.03.19..
//

#include "../include/HttpServer.h"
#include <thread>
#include <functional>
#include <memory>


namespace temp {
    namespace http::server {
        using std::thread;
        namespace beast = boost::beast;
        namespace http = beast::http;
        using socket = boost::asio::ip::tcp::socket;

        void
        fail(beast::error_code ec, char const *what) {
//            std::cerr << what << ": " << ec.message() << "\n";
        }

        int Response::statusCode() const {
            return m_statusCode;
        }

        const Body &Response::responseBody() const &{
            return m_responseBody;
        }

        const Headers &Response::headers() const &{
            return m_headers;
        }

        const string &Request::uri() const &{
            return m_uri;
        }

        const string &Request::method() const &{
            return m_method;
        }

        const Headers &Request::headers() const &{
            return m_headers;
        }

        bool HttpServer::addhandler(const string &path, const RequestHandler &handler) &{
            if (m_handlers.find(path) != m_handlers.end()) {
                // Handler already exists
                return false;
            } else {
                m_handlers[path] = handler;
            }
        }

        bool HttpServer::removeHandler(const string &path) &{
            if (m_handlers.find(path) != m_handlers.end()) {
                m_handlers.erase(path);
            }
        }


        HttpServer::HttpServer(io_context &service) : m_ioContext{service},
                                                      m_acceptor{boost::asio::ip::tcp::acceptor(m_ioContext,
                                                                                                {boost::asio::ip::make_address(
                                                                                                        listenAddr),
                                                                                                 static_cast<unsigned short>(std::atoi(
                                                                                                         listenPort.c_str()))})} {

        }

        void HttpServer::run() &{
        }

        void HttpServer::socket_handler(socket &socket) &{
            beast::error_code ec;
            beast::flat_buffer buffer;

            for (;;) {
                http::request<http::string_body> req;
                http::read(socket, buffer, req, ec);
                auto target = req.target().to_string();
                auto method = http::to_string(req.method());
                auto headers = Headers{};

                for (auto &hdr: req) {
                    headers[to_string(hdr.name()).to_string()] = hdr.value().to_string();
                }

                if (ec == http::error::end_of_stream)
                    break;

                if (ec)
                    fail(ec, "read");

                if (m_handlers.find(target) == m_handlers.end()) {

                } else {
                    Request request{target, method, headers};
                    m_handlers[req.target().to_string()](request);
                }
            }
        }

        void HttpServer::accept_handler(boost::system::error_code ec, boost::asio::ip::tcp::socket &sock) &{

        }
    }
}
