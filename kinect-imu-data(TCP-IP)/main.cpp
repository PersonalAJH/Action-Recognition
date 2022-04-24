#include <iostream>
#include <sstream>
#include <stdbool.h>


#include "NtKinect.h"
#include "CXsensWraper.h"
#include "JH_Timer.h"
#include "SimpleThread.hpp"
#include "TCPIPServer.h"

// CHapticRenderingView

//#include "pch.h"


using namespace std;
CXsensWraper xsensWraper;
JH_timer timer;
bool recording = false;
TCPIPServer server;
int cnt = 1;

void setting() {

	//xsensWraper.setDeviceID("00B43008", 0);
	//xsensWraper.setDeviceID("00B42707", 1); //
	//xsensWraper.setDeviceID("00B43037", 2); //
	//xsensWraper.setDeviceID("00B426BA", 3); //
	//xsensWraper.setDeviceID("00B43009", 4); //
	//xsensWraper.setDeviceID("00B42FED", 5); //
	//xsensWraper.setDeviceID("00B43026", 6); //
	//xsensWraper.setDeviceID("00B42AEE", 7); //
	//xsensWraper.setDeviceID("00B42B8A", 8); //
	//xsensWraper.setDeviceID("00B42BA4", 9); //
	//xsensWraper.setDeviceID("00B426BC", 10);

	//xsensWraper.setDeviceID("00B42B8A", 0); // 오른팔 (손-손목-팔)
	//xsensWraper.setDeviceID("00B42AEE", 1);

	//xsensWraper.setDeviceID("00B42FED", 2); // 왼팔
	//xsensWraper.setDeviceID("00B42BA4", 3); // 




	//xsensWraper.setDeviceID("00B426BC", 0); // 오른다리
	//xsensWraper.setDeviceID("00B43026", 1); //
	//xsensWraper.setDeviceID("00B42FED", 2); //
	//xsensWraper.setDeviceID("00B42AEE", 3);
	//xsensWraper.setDeviceID("00B43008", 4);
	//xsensWraper.setDeviceID("00B42BA4", 5); // 
	//xsensWraper.setDeviceID("00B43037", 6);
	//xsensWraper.setDeviceID("00B42707", 7);
	//xsensWraper.setDeviceID("00B43009", 8);
	//xsensWraper.setDeviceID("00B42B8A", 9);


	//xsensWraper.setXsens();	//0923
	//timer->set_waitTime(30);		//waittime 설정 삭제
	server.init();
	server.dataS.Init = false;



	

}



void doJob() {

	NtKinect kinect;
	FILE* jointrecord;
	
	bool tracking = false;
	char rgbfile[200] = { 0, };
	char depthfile[200] = { 0, };
	char irfile[200] = { 0, };



	while (1) {
		float tmp;
		tmp = timer.Check();
		//printf("check time %f \n", tmp);

		kinect.setRGB();
		kinect.setDepth(false);
		kinect.setInfrared();
		//kinect.setSkeleton();
		cv::Mat rgbImg = kinect.rgbImage;

		cv::Mat depthImg = kinect.depthImage;
		cv::Mat irImg = kinect.infraredImage;
		cv::cvtColor(rgbImg, rgbImg, cv::COLOR_BGRA2BGR);
		cv::resize(rgbImg, rgbImg, cv::Size(777, 424), 0, 0, cv::INTER_CUBIC);
#
		cv::imshow("rgb", depthImg);

		if(recording)
		{
			server.dataS.Init = true;
			server.dataS.idx = cnt;
			sprintf(rgbfile, "D:\\2020.태권도 동작인식\\DATA\\RGB\\rgb%03d.png", cnt);
			sprintf(depthfile, "D:\\2020.태권도 동작인식\\DATA\\Depth\\depth%03d.png", cnt);
			sprintf(irfile, "D:\\2020.태권도 동작인식\\DATA\\InfraRed\\infrared%03d.png", cnt++);
			printf("recording");
			cv::imwrite(rgbfile, rgbImg);
			cv::imwrite(depthfile, depthImg);
			cv::imwrite(irfile, irImg);
		}


		

		//printf("thread\n");
		//simple_thread->sleep(1);

		if (recording==1) {
		}
		else {
			server.dataS.Init = false;
		}



		printf("%d\n", cnt);
		server.recieveData(server.dataR, sizeof(server.dataR));
		server.sendData(server.dataS, sizeof(server.dataS));
		//server.recieveData2(server.dataR, sizeof(server.dataR));
		//server.sendData2(server.dataS, sizeof(server.dataS));










		auto key = cv::waitKey(5);
		if (key == 's')
		{
			recording = true;
			printf("%d\n", recording);
			
		}
		if (key == 't')
		{
			recording = false;
		}


	}
	cv::destroyAllWindows();
}

int main(int argc, char** argv) {
	setting();



	SimpleThread thread([&](SimpleThread* simple_thread) {
		while (true) {
		
			
		}
	});


	try {
		doJob();
		
	}
	catch (exception &ex) {
		cout << ex.what() << endl;
		string s;
		cin >> s;
	}

	xsensWraper.~CXsensWraper();
	return 0;
}

