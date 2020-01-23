#!/bin/bash

numeralTranlator="/home/jackson/Documents/roman-numeral-translator/numeralTranslator.pl"

for i in {1..3999}
do
	last=`perl /home/jackson/Documents/roman-numeral-translator/numeralTranslator.pl $i`

	translation=`perl /home/jackson/Documents/roman-numeral-translator/numeralTranslator.pl $last`

	if  [ $i -ne $translation ]
	then
		echo $last
		echo $i
		echo $tranlsation
	fi
done
