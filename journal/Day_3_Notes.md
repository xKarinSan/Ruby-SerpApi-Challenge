## 7/3/25 Summary
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