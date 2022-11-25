compile:
	g++ cpp_files/server.cpp -o server -std=c++14 -lpthread
	g++ cpp_files/client.cpp -o client
	g++ cpp_files/gen_transactions_file.cpp -o gentransc -std=c++14
	g++ cpp_files/gen_transactions_file_w_rate.cpp -o gen_transactions_file_w_rate -std=c++14

server:
	g++ cpp_files/server.cpp -o server -std=c++14 -lpthread

client:
	g++ cpp_files/client.cpp -o client

gentransc:
	g++ cpp_files/gen_transactions_file.cpp -o gentransc -std=c++14

gentransc_rate:
	g++ cpp_files/gen_transactions_file_w_rate.cpp -o gen_transactions_file_w_rate -std=c++14

clean:
	rm server client gentransc gen_transactions_file_w_rate