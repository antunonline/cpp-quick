//
// Created by ahorvat on 31.03.19..
//
//
#include "gtest/gtest.h"
#include "HttpServer.h"
#include "boost/asio/io_context.hpp"
#include <thread>

namespace temp::http::server::test{

    using boost::asio::io_context;

    TEST(HttpServer, RunServer) {
        io_context ctx;
//        HttpServer server{ctx};
//        std::thread([&server](){
//            server.run();
//        }).detach();



    }

}