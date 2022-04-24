#include "TCPclient.h"


TCPclient::TCPclient(){


}

void TCPclient::init() {

    // Initialize Winsock
    iResult = WSAStartup(MAKEWORD(2, 2), &wsaData);
    if (iResult != 0) {
        printf("WSAStartup failed with error: %d\n", iResult);
        
    }

    ZeroMemory(&hints, sizeof(hints));
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;

    // Resolve the server address and port
    iResult = getaddrinfo("192.168.0.12", DEFAULT_PORT, &hints, &result);
    if (iResult != 0) {
        printf("getaddrinfo failed with error: %d\n", iResult);
        WSACleanup();
        
    }

    // Attempt to connect to an address until one succeeds
    for (ptr = result; ptr != NULL; ptr = ptr->ai_next) {

        // Create a SOCKET for connecting to server
        ConnectSocket = socket(ptr->ai_family, ptr->ai_socktype,
            ptr->ai_protocol);
        if (ConnectSocket == INVALID_SOCKET) {
            printf("socket failed with error: %ld\n", WSAGetLastError());
            WSACleanup();
            
        }

        // Connect to server.
        iResult = connect(ConnectSocket, ptr->ai_addr, (int)ptr->ai_addrlen);
        if (iResult == SOCKET_ERROR) {
            closesocket(ConnectSocket);
            ConnectSocket = INVALID_SOCKET;
            continue;
        }
        break;
    }

    freeaddrinfo(result);

    if (ConnectSocket == INVALID_SOCKET) {
        printf("Unable to connect to server!\n");
        WSACleanup();
        
    }

}


void TCPclient::sendData(char* data, int dataSize)
{
    iSendResult = send(ConnectSocket, (char*)data, dataSize, 0);
    if (iSendResult == SOCKET_ERROR) {
        printf("send failed with error: %d\n", WSAGetLastError());
        closesocket(ConnectSocket);
        WSACleanup();
    }
    //printf("Data sent: %s\n", data);
    //printf("Data size: %d\n", dataSize);
}

float TCPclient::recieveData(char* data, int size)
{
    iResult = recv(ConnectSocket, (char*)data, size, 0);
    if (iResult > 0) {
        //printf("Bytes received: %d\n", iResult);
        //printf("Data: %s\n", data);
    }
    else if (iResult == 0)
    {
        printf("Connection closing...\n");
        close();
        return 0;
    }
    else {
        printf("recv failed with error: %d\n", WSAGetLastError());
        closesocket(ConnectSocket);
        WSACleanup();
        return 0;
    }
    return 0;
}



void TCPclient::close()
{
    iResult = shutdown(ConnectSocket, SD_SEND);
    if (iResult == SOCKET_ERROR) {
        printf("shutdown failed with error: %d\n", WSAGetLastError());
        closesocket(ConnectSocket);
        WSACleanup();
    }
    else {
        // cleanup
        closesocket(ConnectSocket);
        WSACleanup();
    }
}
