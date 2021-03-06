# With most applications, it is important to keep an accurate and comprehensive record of any problems or significant events that occur during its execution. This typically involves sending this information to a log file stored on the computer. The Ruby <a href="http://ruby-doc.org/core/classes/Logger.html" title="Class: Logger">Logger</a> class lets us easily take care of this. 

# After importing 'logger', we can create a new logger like so:
log = Logger.new('server.log')
log.level = Logger::DEBUG

# We want to save all messages into the file 'server.log'. Alternatively, we could have entered 'STDOUT' to send all logging information to standard out. The second line sets the types of messages we want to log, which can be any of
# FATAL:	an unhandleable error that results in a program crash
# ERROR:	a handleable error condition
# WARN:	a warning
# INFO:	generic (useful) information about system operation
# DEBUG:	low-level information for developers
# (Taken from <a href="http://ruby-doc.org/core/classes/Logger.html" title="Class: Logger">Ruby API</a>)

# The level you set log.level to will mean that any messages logged equal to, or above this level, will be logged.
log.level = Logger::WARN
# This would result in FATAL, ERROR and WARN messages being logged, but INFO and DEBUG being ignored. In a production environment you may only want to log fatal errors, while in development mode you would most likely want to see DEBUG information.

# To add a message to the log we can simply call a method that has the name of the level we are logging to.
log.fatal "Program will now crash"
log.error "An exception occurred, but we're onto it"
log.warn "Memory running low"
log.info "1000 customers have now signed up"
log.debug "The program is on line 25"

# Let's modify our multi-threaded server to include some logging.
log = Logger.new('server.log')
log.level = Logger::DEBUG
	
server = TCPServer.new('127.0.0.1', '8080')
log.info "Server started on 127.0.0.1:8080"

buffer = SynchronisedBuffer.new(100)

workers = []

for i in (1..40)
   workers[i] = Worker.new(buffer)
   workers[i][:name] = 'worker' + i.to_s  
   log.info "'Worker #{workers[i][:name]} created"
end

while socket = server.accept
    log.info "New connection from #{socket.peeraddr[2]}"
    buffer.put(socket)
end

# In each case we are printing out some useful, but non-critical information, so it is logged as info. We can also add logging to the <a href="http://www.oneofthesedaysblog.com/serve/thread.rb" title="Thread.rb">worker class</a> -  the file has been attached for brevity's sake.

# If we run the web server with the changes made above, we will see entries in our server.log file like the following:
# Logfile created on Fri Jul 02 19:57:47 +1200 2010 by logger.rb/22285

# I, [2010-07-02T19:57:54.231591 #14068]  INFO -- : New connection from localhost

# I, [2010-07-02T19:57:54.232061 #14068]  INFO -- : worker1 has received a new socket

# As each message has a precise timestamp, it can useful for tracking down bugs and performance issues. While 'puts' may be a simpler and quicker method for printing out this kind of information to standard out, the extra information and structure that logger provides makes it well worth using.
