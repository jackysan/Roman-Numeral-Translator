#!/usr/bin/perl
	
$help = <<'END_BLOCK';
This program translates roman numerals to integers and vice versa. Enter a roman
numeral in all caps (only numerals [IVXCLDM]) as the first argument to see them
as an integer.

		OR

Enter a integer number like 42 and get it in roman numerals. No decimals or
negative numbers. Numbers between 1 and 3999.

		OR

Enter something else to see this message
END_BLOCK

#Function that translates single roman numeral to integer
sub romanCharToInt {
	$numer = $_[0];
	if ($numer =~ m/^I$/) { return 1;}
	elsif ($numer =~ m/^V$/) { return 5;}
	elsif ($numer =~ m/^X$/) { return 10;}
	elsif ($numer =~ m/^L$/) { return 50;}
	elsif ($numer =~ m/^C$/) { return 100;}
	elsif ($numer =~ m/^D$/) { return 500;}
	elsif ($numer =~ m/^M$/) { return 1000;}

	else { return "WOWOW you broke it";}
}

#there are only 6 cases valid for subtraction IV, IX, XL, XC, CD, CM
sub checkValSubtract {
	$prev = $_[0];
	$curr = $_[1];

	if ($prev == 1 && $curr == 5) { return true;}
	elsif ($prev == 1 && $curr == 10) { return true;}
	elsif ($prev == 10 && $curr == 50) { return true;}
	elsif ($prev == 10 && $curr == 100) { return true;}
	elsif ($prev == 100 && $curr == 500) { return true;}
	elsif ($prev == 100 && $curr == 1000) { return true;}
	else {return false;}
}

sub translateThous {
$num = $_[0];

	if ($num == 1) {return M;}
	elsif ($num == 2) {return MM;}
	elsif ($num == 3) {return MMM;}
	else { 
		print $help;
		exit();
		return;
	}
}

sub translateHunds {
	if ($num == 1) {return C;}
	elsif ($num == 2) {return CC;}
	elsif ($num == 3) {return CCC;}
	elsif ($num == 4) {return CD;}
	elsif ($num == 5) {return D;}
	elsif ($num == 6) {return DC;}
	elsif ($num == 7) {return DCC;}
	elsif ($num == 8) {return DCCC;}
	elsif ($num == 9) {return CM;}
	elsif ($num == 0) {return "";}
	else { 
		print $help;
		exit();
		return;
	}
}

sub translateTens {
	if ($num == 1) {return X;}
	elsif ($num == 2) {return XX;}
	elsif ($num == 3) {return XXX;}
	elsif ($num == 4) {return XL;}
	elsif ($num == 5) {return L;}
	elsif ($num == 6) {return LX;}
	elsif ($num == 7) {return LXX;}
	elsif ($num == 8) {return LXXX;}
	elsif ($num == 9) {return XC;}
	elsif ($num == 0) {return "";}
	else { 
		print $help;
		exit();
		return;
	}
}

sub translateOnes {
	if ($num == 1) {return I;}
	elsif ($num == 2) {return II;}
	elsif ($num == 3) {return III;}
	elsif ($num == 4) {return IV;}
	elsif ($num == 5) {return V;}
	elsif ($num == 6) {return VI;}
	elsif ($num == 7) {return VII;}
	elsif ($num == 8) {return VIII;}
	elsif ($num == 9) {return IX;}
	elsif ($num == 0) {return "";}
	else { 
		print $help;
		exit();
		return;
	}
}



#Default valiable in perl being uses in the if';
$_= $ARGV[0];

if (/^\d+$/) {
	#print "That's an int\n";
	$ans = "";
	$iter = 0;
	$num = 0;
	foreach (split //, reverse($_)) {
	$num = $_;
	if ($iter == 0) {
			$ans = translateOnes($num);
			$iter++;
		}
		elsif ($iter == 1) {
			$ans = translateTens($num) . $ans;
			$iter++;
		}
		elsif ($iter == 2) {
			$ans = translateHunds($num) . $ans;
			$iter++;
		}
		elsif($iter == 3) {
			$ans = translateThous($num) . $ans;
			$iter++;
		}
	
	}
	print $ans, "\n";
}
elsif (/^[IVXLCDM]+$/) {
	#print "That's a roman numeral\n";
	$num = 0;
	$prev = 1001;
	foreach (split //, $_) {
		$curr = romanCharToInt($_);

		if ($curr <= $prev) {
			$num += $curr;
			$prev = $curr;
		}
		elsif ( checkValSubtract($prev, $curr )) {
			$num += ($curr - 2*$prev);
			$prev = $curr;
		}
		else {
			print "Invalid roman numeral\n";
			exit();
		}
	}
	print $num, "\n";
}
else {
	print $help;
}

