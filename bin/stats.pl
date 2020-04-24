#!/usr/bin/perl

# stats.pl - returns CPU and RAM usage


# CPU stuff

my $cpuusage = `top -bn 2 -d 0.2 | grep '^%Cpu' | tail -n 1 | gawk '{print \$2+\$4+\$6}'`;
chomp $cpuusage;
$cpuusage =~ s/^([0-9][0-9]*)(\.[0-9][0-9]*)$/$1/;
printf "CPU: %02d%% ","$cpuusage";


# RAM stuff

my $total = `grep -e "^MemTotal" -m 1 /proc/meminfo`;
$total =~ s/([^0-9]*)([0-9]*)(.*)$/$2/;

my $available = `grep -e "^MemAvailable" -m 1 /proc/meminfo`;
$available =~ s/([^0-9]*)([0-9]*)(.*)$/$2/;

my $memusage = 100 - ($available / $total * 100);
printf "RAM: %02d%%\n","$memusage";