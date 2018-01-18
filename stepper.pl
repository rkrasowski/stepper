#!/usr/bin/perl
use strict;
use warnings;
use Time::HiRes qw(usleep nanosleep);
use WiringPi::API qw(:all);


my $dirPin = 20;
my $controlPin = 21;
my $resPin1 = 14;
my $resPin2 = 15,
my $resPin3 = 18;


my $rps = 1;				# Speed rotation per minute
my $numRot = 1;				# Number of full rotation
my $dir = 1;				# 1 - CCW	0 - CW





my $delay = 1/$rps * 1000;

print "Delay is $delay\n";


my $api= WiringPi::API-> new;
$api = int wiringPiSetupGpio();
$api = pinModeAlt($dirPin,1);
$api = pinModeAlt($controlPin,1);

$api = digitalWrite($dirPin,1);

$api = digitalWrite($resPin1,1);
$api = digitalWrite($resPin2,0);
$api = digitalWrite($resPin3,1);


my $delayTemp = 50000;

my $num = 800 * $numRot;
for (my $i = 0; $i <= $num; $i++)
	{
		$api = digitalWrite($controlPin,1);
		usleep($delayTemp);
		$api = digitalWrite($controlPin,0);
		usleep($delayTemp);
		
		until ($delayTemp == $delay)
	       		{	
				$delayTemp = $delayTemp - 1;
				print "DelTemp = $delayTemp\n";
			}
	}

 print "Script is running\n";

