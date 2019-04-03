


# Once LXD Alpine is installed and all dependencies are prepared, do the following to map the project dir into Alpine linux
lxc config device add alpinecontainer cpp-quick-demo-mapping-name disk source=/home/ahorvat/Projects/CLionProjects/cpp-quick-demo path=/build/cpp-quick-demo