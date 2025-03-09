## 7/3/25 Entry
I first tried to pick up Ruby on Rails by understanding in terms of how it is similar to other frameworks in other lanugages. According to the documentation <a href="https://guides.rubyonrails.org/getting_started.html">here</a>, it seems to use the MVC architecture, similarly to C# WPF.

According to the official documentation, I have learnt:
- Databases
    - Creation of models: ```generate model <Model_Name> attr:data_type```
    - Migrations: ```bin/rails db:migrate```
    - CRUD (Create, Read, Update, Delete) of records
        - Create: Similar to instantiating a class
        - Read: Retrieve/Query records
            - ```.all``` : all instances
            - ```where(column:value)```: filter by column
            - ```find()```: find by ID
        - Update:
            - ```upadte(column:value)```: Update column values
            - By the attribute name; because of ```attr_accessor```
        - Delete:
            - ```.destroy```: remove record from database

I have also learnt that:
- ```render``` tag is similar to rendering components in React.JS, after specifying the name of the component in the ```view``` folder


I have the following questions:
- How does the router work under the hood? (more towards visualisation)
    - the routes are defined inside the ```routes.rb``` in the ```config``` folder of the project
- Since the MVC architecture is for the full-stack application, what does the architecture of a Ruby on Rails project look-like for a pure backend server?
- Not only that but the documentation mentioned about database migration for SQL. How does it work if the database is a NoSQL database (especially for MongoDB)?


I have also tried the following tutorial on youtube <a href ="https://www.youtube.com/watch?v=aigDyaxGsRo&t=46s">here</a>, to have a better grasp of creating a Ruby on Rails REST API. Here is what I have learnt:
- Add a ```--api``` when creating a rails project like: ```rails new project_name --api``` to create a REST api for rails.
- ```render json:``` is how json repsonses are rendered in the controller
- ```@results.as_json(only:[:col1, col2])``` means to format the json response such that each row has only col1 and col2 displayed.

After which, I have also tried to explore
- error handling
- response messages

And here they are:
- error handling: instead of  ```try```, ```except``` and ```finally``` like it was in Python, it is ```begin```, ```rescue``` and ```ensure``` respectively, and there is also an ```else``` which catches any other errors that are not handled.
- add the ```status``` like this: ```render json :@results, status: ok```, which means the response will be returned to the client with the repsonse code ``200``. It is found <a href="https://www.youtube.com/watch?v=36M2BSA2LYk">here</a>.
- the error handling logic should also be in the functions at before_action
- ```before_action```: a callback method before a controller takes action

***TL;DR: Learned **Ruby on Rails** by comparing it to other frameworks, exploring **MVC architecture, database operations, REST API creation, error handling, and response messages**, while raising questions about **routing, backend-only architecture, and NoSQL migrations**. 🚀***