## 8/3/25 Summary
I tried to understand logging in the context of Ruby on Rails, and attempted implementing because it is important for maintenance and troubleshooting for events such as server crashing as well as API failing.  

This is the site which I tried to figure out how to log. (https://betterstack.com/community/guides/logging/how-to-start-logging-with-ruby-on-rails/#step-6-configuring-logger). I have learnt that:
- It was unnecessary to build a separate Logger class as Ruby on Rails has already provided an in-built logging functions which are configurable inside ```application.rb``` inside the ```config``` folder, and accessible through other controllers.
- ```config.log_level``` means to set the minimum level of logging which will be registered. When I set this attribute to ```warn```, logs with lower level (ie: ```info```) are not registerd. However, if they the log_level is the same level or lower than the output log, the log will be sent to the ```.log``` file

In order for the logging to make sense as well as to learn its best practices, I have also read through this article here (https://betterstack.com/community/guides/logging/logging-best-practices/). Thus, I have picked up the essentials, and these are written based on my understanding:
- Logging levels (top-down):
    - info: a normal event; this can be used for tracking frequency of activity.
    - warn: abnormal situations which may mean future problems
    - error: this is usually triggered in failed operations (ie: records not found)
    - fatal: affects whole program (this is in the event which app crashes)
- Though logs are useful in debugging, they should NOT be used for monitoring as they will take up space, which can translate to high costs especially when these logs are stored in data storages. Instead, tools such as Amazon Cloud Watch should be used for monitoring, as they contain the relevant metrics (ie: GPU usage and number of requests) required for monitoring.
- Properly structuring logs. An example would be ```POST /endpoint 404 Endpoint not found```. This log would show the HTTP method used, as well as the endpoint accessed and the error message.


While implementing the logging, one of the challenges I faced was proper error handling for the REST API endpoints. What I have learnt:
- raise the error to redirect the flow to the rescue statement with that error
- add ```and return``` to prevent more than one renders, which lead multiple renders in 1 action


After understanding the basics of REST APIs in Ruby on Rails, I have decided to SerpApi.
As SerpApi requires a an API, I would need to pick up on how to access environment variables for ruby, as it is an unsafe practice to expose an existing API key and publish it on GitHub as unauthorised access may incur excess costs as well as data breaches should sensitive data be involved. Based on my experience in other languages and framework, this is feasible using a ```.env``` file. Therefore, I tried to search for a way to do it in ruby and found it <a href="https://www.youtube.com/watch?v=KRzt_vTZaLQ">here</a>. Basically we need to install a package (or gem in this case) called "dotenv", and then load it and get the key inside ```.env```, using ```ENV[variable_key]``` (in this format.)

When I tried the youtube search use case with the sample code on SerpApi's official website, it did not work because there is an error message which states that it lacks the parameter 'q'. As such, I went to search the code under the hood (inside the gem) and realised that 'q' means query. This issue was resolved after I added 'q' inside the parameters json.

Not only that but when I experimented with SerpApi, I realised that they also have a sandbox page in the web, which is an interesting feature, as not only I can experiment their API there, I can also intergrate the code from the sandbox page (which allows exporting of code) into my codebase.