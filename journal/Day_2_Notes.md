## 6/3/25 Summary
I came up with the example of package delivery while experimenting on the syntax of ruby, and believe that package delivery would a strong case especially when ecommerce is very prevelant in my country, Singapore, with E-commerce giants such as Lazada, Shopee and Taobao. As such, I created a simple implementation of the following 2 classes
- ```ItemPackage```: It basically contains the items to be delivered, as well as the identification of the recipient. its status is also tracked so that it is easier to monitor problems such as tampering
- ```PackageFactory```: In this case, it would be a supplier which takes orders from customers, as well as to deliver the packages to said customers.

If I were to link this examples to HTTP requests, the PackageFactory would represent the backend server, whereas the ItemPackage will represent the payload sent by the client.

I also added the following classes in Logs.rb
- ```LogItem```: It stores the log information such as the date of the log generated (timestamp), method (HTTP method) as well as the involved payloads
- ```Logger```: It creates and stores logs after each activity is triggered, and they can be displayed.

I decidede to add these logger classes for the sake of monitoring. Linking back to API developments, these are extremely crucial when debugging and troubleshooting due to the information that they have. In the code level, it usually tells us which line(s) are causing the error. 