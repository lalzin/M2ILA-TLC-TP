Simon LEDOUX-LEVIN
Alan MARZIN

TLC Project - Google App Engine
ISTIC - Master 2 ILA - 2017/2018

APPLICATION URL: https://proj-pub-cuicui.appspot.com/

1 - Development of the 'MegaAds4U' application

For the TLC project, we developed a web application with JAVA technologies: servlet and JSP.
This application has been developed with Google's cloud application engine.
The principle of deployment through a distributed infrastructure an autonomous application.
The purpose of the app was to allow users to add ads in a list
and others users can consult the ads posted (in the chosen category).

Several features have been applied:
-View the list of ads in a category
-Change category
-Add an ad
-Add a list of ads
-Remove an ad
-Filter the list of ads with a keyword

The data has been stored in the Google application engine (datastore) , a database accessible from the web application.

Here are the types of data (collections) inserted into the datastore:
- Category (property: a name, a list of Ads)
- Ads (property: a title, price, description, and date added)

We used the Bootstrap library for the style of our web application.


2 - Load and performance test

To check the behavior of our application in the cloud, we created a program
That control the latency of our application. To do this, we first test our app
on our localhost computer (without the benefits of google app engine).

We then create a Java program that initializes 10 threads that create Ads from a list.
The name of this project is measure.

Result of performance and load tests:

LOCALHOST APP:
******** START throwing threads *********
******** END launch of the discussions) *********
[REQ Num3] Latency = 3975 ms
[REQ Num1] Latency = 4843 ms
[REQ Num7] latency = 6608 ms
[REQ Num9] latency = 7509 ms
[REQ Num0] latency = 8816 ms
[REQ Num4] latency = 9161 ms
[REQ Num6] latency = 9300 ms
[REQ Num2] latency = 9507 ms
[REQ Num5] latency = 10321 ms
[REQ Num8] latency = 10371 ms

We notice that the latency time increases sharply as there are requests.
Our server can not parallelize the processing of our requests.


GOOGLE APP MOTOR APP:
******** START throwing threads *********
******** END launch of the discussions) *********
[REQ Num2] latency = 1278 ms
[REQ Num7] latency = 1274 ms
[REQ Num3] latency = 1508 ms
[REQ Num0] latency = 1913 ms
[REQ Num9] latency = 2065 ms
[REQ Num4] latency = 2603 ms
[REQ Num8] latency = 2806 ms
[REQ Num6] latency = 3073 ms
[REQ Num5] latency = 3079 ms
[REQ Num1] latency = 3607 ms


Here we run the same program on our Google Application Engine web server.
The latency of our threads is complementarily different.
The treatments are much faster and even if there is an increase in the latency,
It is much lighter than in localhost.
The Google application engine reduces this latency because it can initialize multiple instances of 
our application to handle the high query request.

3- Conclusion

Thanks to the TLC module, we were able to be introduced to the development in the cloud.
We have seen the differential benefits of the PaaS cloud.
We did not have to worry about our infrastructure and data management,
we focus on the development of the app.
In addition, the Google App engine automatically deploys our application across multiple instances based on demand.
It would have been difficult for us to manage this part of our applications (load balancing, ...)
However, we also found that the installation of the environment (SDK, project maven, ...)
some problems at the beginning of the project which makes us lose some time.