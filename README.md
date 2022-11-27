# client_server_app

# DistributedOS

This is my cpp implementation of a centralized bank account management system. It supports one server and multtiple clients. The server creates a seperate thread for each client. It ensures the data safety on server side via adding mutex/lock on account data.


## Environments:

All tests are on MacOS Ventura 13.0.1, c++ version 14.

---

# A Centralized Multi-User Concurrent Bank Account Manager (Multithreading, Synchronization, Mutex)

The system has two important components:
1. **Bank Server**:
The server program that services online requests for account manipulations and maintains all customer records correctly.
2. **Clients**:
Customers are clients of the bank server and use its services to update bank accounts. The operations that can be performed on an account are: withdrawl of an amount from an account and deposit of an amount into an account. Additionally, the bank server can have it's own service that periodically deposits an interest amount to each account based on some fixed rate.

State diagram for server and client model:

![](./docs/server_client_model.png)

## Explanation

### **1. Synchronization**

The assignment says "It should provide locking/protection for access to an account records during shared access (i.e., a user might be depositing money into his account and at the same time an online billing agent might be withdrawing money from the same account). Such cases need to be correctly handled by protecting variables in the critical section."

I set up a mutex lock for each account. So when d/w it will ask for the lock first and then finish the transaction operation, followed by unlock corresponding account. Check out server.cpp line 132 transaction_oper() function.


### **2. High transaction volume (synchronization proof)**

If the transaction amount is small, like 1000, the server deal with them quickly and cannot generate the running time overlap between  multiple clients. The server executes transactions so fast, making the execution become sequential, i.e. it finishes all 1000 transactions for client 1 (because so fast) and then finishes all 1000 transacttionf for client 2.

So I set up 10000 transactions (rate = 10, every one transaction per 10 milliseconds) and all on the  same account 101, insuring there will be a running time overlap between two clients in my demonstration. This generated a about 2 seconds overlap, i.e. the last 2 s running time of transactions of client 1 and the first 2 s running time of transactions of client 2. During these 2s the 2 client threads competed for the lock of the account 101.


To run it, open first terminal, run
```linux
make
```
```linux
./gentransc
```
```linux
./server
```

Open second termial, run
```linux
./client
```

Open third termial, run
```linux
./client
```

Below is the screenshot that shows Synchronization.
![](./docs/server_logs_synchronization_example.png)

### **3. Scalability**

### ***3.1 Transaction avg complete time (ms) over clients amount***

||||||
|-|-|-|-|-|
|Clients amount|1|5|10|15
|Transaction avg complete time (ms)|0.0003|0.0006|0.00117143|0.00155455|
||

![](./docs/scalability_01.png)

---

### **3.2 Transaction avg complete time (ms) over transaction rate (one transaction every rate milliseconds)**

|||||||||
|-|-|-|-|-|-|-|-|
|rate|0.1|1|5|10|50|100|200|
|Transaction avg complete time (ms)|0.00201|0.00165|0.00166|0.00188|0.0022|0.00292|0.00219|
||

![](./docs/scalability_02.png)


### References:

Socket:

1. [Socket programming example 1](https://www.geeksforgeeks.org/socket-programming-cc/?ref=lbp)
2. [Socket programming example 2](https://stackoverflow.com/a/69309213/9593219)

Multithread:

3. [pthread_join need to be outside of pthread_create loop](https://stackoverflow.com/questions/38153680/integrating-pthread-create-and-pthread-join-in-the-same-loop)

Mutex:

4. [pthread_mutex](https://stackoverflow.com/questions/34100575/c-using-mutex-in-multithreaded-client-and-server)

Linux:

5. [Launch multiple ./client programs in parallel from a bash script](https://stackoverflow.com/a/3004814/9593219)
