
#include "JH_timer.h"



void JH_timer::reset()
{
	start = clock();
}

void JH_timer::Start()
{
	start = clock();

}

float JH_timer::Check()
{
	float ret;
	clock_t tmp = clock();;
	ret = -(float)start + (float)tmp;
	reset();
	return ret;
}

void JH_timer::set_waitTime(float wait_time)
{
	waitTime = wait_time;
}

bool JH_timer::isExpired() {
	current_time = clock();

	if (waitTime < current_time - previous_time) {
		previous_time = clock();
		return true;
	}

	return false;
}




