#for ALG in 3 4 5 6 7
for ALG in 1 2 8
do
#	for LEN in 25000 50000 100000 150000 200000 250000 300000 350000 400000 450000 500000 550000 600000 650000 700000 750000 800000 850000 900000 950000 1000000 1500000 2000000 2500000 3000000 3500000 4000000 4500000 5000000 5500000 6000000 6500000 7000000 7500000 8000000 8500000 9000000 9500000 10000000
	for LEN in 25000 50000 100000 150000 200000 250000 300000 350000 400000 450000 500000 550000 600000 650000 700000 750000 800000 850000 900000 950000 1000000

	do
		./Sort $LEN 1 $ALG >> RESULT.txt
	done

done




