#!/bin/bash
rate=0.1 # input 0.1, 1, 5, 10, 50, 100, 200  milliseconds

echo "" > "avg_transaction_complt_time_log.txt" # clean file

./gen_transactions_file_w_rate $rate

# This takes the number of clients to run from the user.
k=15

for ((i = 1; i <= $k; i++))
do
	# The ( & ) ensures that the clients runs in parallel.
	./client &
done
exit(0)
