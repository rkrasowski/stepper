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

my $complRot = $num / $numRot;
my $j = 1;

for (my $i = 0; $i <= $num; $i++)
	{
		$api = digitalWrite($controlPin,1);
		usleep($delay);
		$api = digitalWrite($controlPin,0);
		usleep($delay);
		

		if ($i ==  $complRot)
			{
				print "Rotation number $j\n";
				$j++;
				$complRot = $complRot + $num / $numRot;

			}
	}




sleep(1);

#reverse direction

$api = digitalWrite($dirPin,0);

for (my $i=0; $i <= $num; $i++)
	{
		$api =  digitalWrite($controlPin,1);
		usleep($delay);
		$api = digitalWrite($controlPin,0);
		usleep($delay);

	}
