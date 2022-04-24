//#include "pch.h"

#include "TCPIPServer.h"

TCPIPServer::TCPIPServer()
{
	//dataS.Value = 12.3f;

}

TCPIPServer::~TCPIPServer()
{
}

int TCPIPServer::init()
{

	// Initialize Winsock
	iResult = WSAStartup(MAKEWORD(2, 2), &wsaData);
	if (iResult != 0) {
		printf("WSAStartup failed with error: %d\n", iResult);
		return 1;
	}

	ZeroMemory(&hints, sizeof(hints));
	hints.ai_family = AF_INET;
	hints.ai_socktype = SOCK_STREAM;
	hints.ai_protocol = IPPROTO_TCP;
	hints.ai_flags = AI_PASSIVE;

	// Resolve the server address and port
	iResult = getaddrinfo(NULL, DEFAULT_PORT, &hints, &result);
	if (iResult != 0) {
		printf("getaddrinfo failed with error: %d\n", iResult);
		WSACleanup();
		return 1;
	}

	// Create a SOCKET for connecting to server
	ListenSocket = socket(result->ai_family, result->ai_socktype, result->ai_protocol);
	if (ListenSocket == INVALID_SOCKET) {
		printf("socket failed with error: %ld\n", WSAGetLastError());
		freeaddrinfo(result);
		WSACleanup();
		return 1;
	}

	// Setup the TCP listening socket
	iResult = bind(ListenSocket, result->ai_addr, (int)result->ai_addrlen);
	if (iResult == SOCKET_ERROR) {
		printf("bind failed with error: %d\n", WSAGetLastError());
		freeaddrinfo(result);
		closesocket(ListenSocket);
		WSACleanup();
		return 1;
	}

	freeaddrinfo(result);

	iResult = listen(ListenSocket, SOMAXCONN);
	if (iResult == SOCKET_ERROR) {
		printf("listen failed with error: %d\n", WSAGetLastError());
		closesocket(ListenSocket);
		WSACleanup();
		return 1;
	}

	// Accept a client socket
	ClientSocket = accept(ListenSocket, NULL, NULL);
	if (ClientSocket == INVALID_SOCKET) {
		printf("accept failed with error: %d\n", WSAGetLastError());
		closesocket(ListenSocket);
		WSACleanup();
		return 1;
	}
	else
		printf("Client1 connected!\n");


	/*
	// Accept a client socket
	ClientSocket2 = accept(ListenSocket, NULL, NULL);
	if (ClientSocket2 == INVALID_SOCKET) {
		printf("accept failed with error: %d\n", WSAGetLastError());
		closesocket(ListenSocket);
		WSACleanup();
		return 1;
	}
	else
		printf("Client2 connected!\n");
	*/

	// No longer need server socket
	closesocket(ListenSocket);


	//2번째 Listen Socket 만들기













	return 0;
}

//void TCPIPServer::sendData()
//{
//	iSendResult = send(ClientSocket, (char*)&dataS, sizeof(dataS), 0);
//	if (iSendResult == SOCKET_ERROR) {
//		printf("send failed with error: %d\n", WSAGetLastError());
//		closesocket(ClientSocket);
//		WSACleanup();
//	}
//	//printf("Bytes sent: %d\n", iSendResult);
//}




//float TCPIPServer::recieveData(float posZ)
//{
//	dataS.posZ = posZ;
//	iResult = recv(ClientSocket, (char*)&dataR, sizeof(dataR), 0);
//	if (iResult > 0) {
//		//printf("Bytes received: %d\n", iResult);
//		//printf("Data: %f\n", dataR.forceZ);
//
//		sendData();
//	}
//	else if (iResult == 0)
//	{
//		printf("Connection closing...\n");
//		close();
//		return 0;
//	}
//	else {
//		printf("recv failed with error: %d\n", WSAGetLastError());
//		closesocket(ClientSocket);
//		WSACleanup();
//		return 0;
//	}
//	return dataR.forceZ;
//}

void TCPIPServer::close()
{
	iResult = shutdown(ClientSocket, SD_SEND);
	if (iResult == SOCKET_ERROR) {
		printf("shutdown failed with error: %d\n", WSAGetLastError());
		closesocket(ClientSocket);
		WSACleanup();
	}
	else {
		// cleanup
		closesocket(ClientSocket);
		WSACleanup();
	}
}


void TCPIPServer::sendData(StoC data, int dataSize)
{
	data = dataS;
	iSendResult = send(ClientSocket, (char*)& data, dataSize, 0);
	if (iSendResult == SOCKET_ERROR) {
		printf("send failed with error: %d\n", WSAGetLastError());
		closesocket(ClientSocket);
		WSACleanup();
	}
	//printf("Data sent: %s\n", data);
	//printf("Data size: %d\n", dataSize);
}


int TCPIPServer::sendData2(StoC data, int dataSize)
{
	//dataS.Value = 11.1f;		// 수정 -> debug용

	data = dataS;
	iSendResult = send(ClientSocket2, (char*)& data, dataSize, 0);
	if (iSendResult == SOCKET_ERROR) {
		printf("send failed with error: %d\n", WSAGetLastError());
		closesocket(ClientSocket2);
		WSACleanup();
	}
	//printf("Data sent: %s\n", data);
	//printf("Data size: %d\n", dataSize);
	return 0;
}


float TCPIPServer::recieveData(CtoS& data, int size)
{
	CtoS tmp;
	tmp.nonValue = 0.0f;

	iResult = recv(ClientSocket, (char*)& data, size, 0);
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
		closesocket(ClientSocket);
		WSACleanup();
		return 0;
	}

	return 0;
}

int TCPIPServer::recieveData2(CtoS& data, int size)

{
	CtoS tmp;
	tmp.nonValue = 0.0f;

	iResult = recv(ClientSocket2, (char*)& data, size, 0);
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
		closesocket(ClientSocket2);
		WSACleanup();
		return 0;
	}

	return 0;
}




int TCPIPServer::recieveData3(CtoS& data, int size)

{
	CtoS tmp;
	tmp.nonValue = 0.0f;

	iResult = recv(ClientSocket2, (char*)& data, size, 0);
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
		closesocket(ClientSocket2);
		WSACleanup();
		return 0;
	}

	return 0;
}


