#!/usr/bin/perl
use strict;
use warnings;
use Time::HiRes qw(usleep nanosleep);
use WiringPi::API qw(:all);


my $dirPin = 20;
my $controlPin = 21;


#my $rps = 1;;				# Speed rotation per minute
#my $numRot = 1;				# Number of full rotation
#my $dir = 1;				# 1 - CCW	0 - CW

my $rps = $ARGV[0];
my $numRot = $ARGV[1];
my $dir = $ARGV[2];
print "Speed is $rps/rps\nNumber of rotation is  $numRot\n";



my $api= WiringPi::API-> new;
$api = int wiringPiSetupGpio();
$api = pinModeAlt($dirPin,1);
$api = pinModeAlt($controlPin,1);

$api = digitalWrite($dirPin,$dir);


my $delay = 1/$rps * 600;
my $num = 800 * $numRot;



#for (my $i=0; $i=500; $i++)
#	{
#		$api = digitalWrite($controlPin,1);
#		usleep($delay);
#		$api = digitalWrite($controlPin,0);
#		usleep($delay);
#	}



while (1)

	{	
		$delay = $delay + 1000;
		for (my $i=0; $i <= 1; $i++)
			{
				$api =  digitalWrite($controlPin,1);
				usleep($delay);
				$api = digitalWrite($controlPin,0);
				usleep($delay);
				print "Delay is $delay\n";
			}


	}
