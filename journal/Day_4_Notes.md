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