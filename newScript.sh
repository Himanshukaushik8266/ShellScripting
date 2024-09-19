#!/bin/bash

# Run a container from the Ubuntu image
container_id=$(docker run -d ubuntu:latest sleep infinity)

# Execute commands inside the container to create the folder and file
docker exec $container_id mkdir /ohyes
docker exec $container_id bash -c 'cat <<EOF > /ohyes/fibonacci.cpp
#include <iostream>
using namespace std;

int main() {
    int n, t1 = 0, t2 = 1, nextTerm = 0;
    cout << "Enter the number of terms: ";
    cin >> n;
    cout << "Fibonacci Series: ";
    for (int i = 1; i <= n; ++i) {
        if(i == 1) {
            cout << t1 << ", ";
            continue;
        }
        if(i == 2) {
            cout << t2 << ", ";
            continue;
        }
        nextTerm = t1 + t2;
        t1 = t2;
        t2 = nextTerm;
        cout << nextTerm << ", ";
    }
    return 0;
}
EOF'

# Commit the container to a new image
docker commit $container_id naya-ubuntu:1.01

# Stop and remove the container
docker stop $container_id
docker rm $container_id

echo "Docker image 'MerewalaUbuntu' created successfully."

