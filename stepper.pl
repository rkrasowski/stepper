#!/usr/bin/perl

#################################################################################
#										#
#	Perl script to control Stepper Motor 17NEMA 4 wires. 			#
#	Example newControler.pl 1 2 0 						#
#	Turn 2 rotations, speed 1 RPS, direction CW				#
#	by Robert J Krasowski							#
#	18 Jan 2018								#
#										#
#################################################################################

use strict;
use warnings;
use Time::HiRes qw(usleep nanosleep);
use WiringPi::API qw(:all);
 
# Setting up pins to control stepper motor
#
my $dirPin = 20;
my $controlPin = 21;



my $rps = $ARGV[0];			# Speed: rotation per minute	
my $numRot = $ARGV[1];			# Number of rotation, can be in fraction	
my $dir = $ARGV[2];			# Direction of rotation 1 - CCW 0 - CW



my $api= WiringPi::API-> new;
$api = wiringPiSetupGpio();
$api = pinModeAlt($dirPin,1);
$api = pinModeAlt($controlPin,1);
$api = digitalWrite($dirPin,$dir);


rotate($rps,$numRot,$dir);




sub rotate {

	my $rpsInt = shift;
	my $numRotInt = shift;
	my $dirInt = shift;

	my $delay = 1/$rpsInt * 600;
	my $num = 800 * $numRotInt;
	my $j = 1;
	my $i;

	my $complRot = $num /$numRotInt;
	
	my $dirText;
	if ($dirInt == 1 )
		{
			$dirText = "CCW";
		}
	else
		{
			$dirText = "CW";
		}
	
	for ($i=0; $i<=$num; $i++)
		{
			$api = digitalWrite($controlPin,1);
			usleep($delay);
			$api = digitalWrite($controlPin,0);
			usleep($delay);

			if ($i == $complRot)
				{
					print"Rotation number $j $dirText\n";
					$j++;
					$complRot = $complRot + $num / $numRot;
				}

		}

		my $totalRotationFinal = ($i/800) - 0.00125;
		print "Total number of rotation performed was $totalRotationFinal\n";
	}






