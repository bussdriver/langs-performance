use strict;
use warnings;
use Time::HiRes qw(gettimeofday);

sub get_primes7($) {
	my $n= $_[0];

	return		if $n < 2;
	return (2)	if $n == 2;
	# do only odd numbers starting at 3
	my @s;
	for (my $i = 3; $i < $n + 1; $i += 2) {
		push @s, $i;
	}
	# n**0.5 simpler than math.sqr(n)
	my $mroot = $n ** 0.5;
	my $half = scalar @s;
	my $i = 0;
	my $m = 3;
	my $j;
	while ($m <= $mroot) {
		if ($s[$i]) {
			$j = int(($m*$m - 3) * 0.5);
			$s[$j] = 0;
			while ($j < $half) {
				$s[$j] = 0;
				$j += $m;
			}
		}
		$m = 2* ++$i + 3;
	}
	return grep {$_} 2,@s;
}

my $startTime = gettimeofday();
my $periodTime = $ENV{'RUN_TIME'};

my @res;

while (gettimeofday() - $startTime < $periodTime) {
	@res = get_primes7(10000000);
	print "Found $#res prime numbers.\n";
}
