Poor Man's Service Monitor
==========================

A ridiculously primitive way to monitor the health of a web service or web site using only cron, curl, sendmail and HTTP status codes.


Install
-------

Clone the script, make it executable, and make sure of the following:
* You have cron, curl and sendmail installed
* What you want to monitor is somehow HTTP based
* What you want to monitor always returns the same status code as long as things are peachy

If the mail transfer agent on your system is not configured for non-local mail delivery, you might want to consider using msmtp -- it essentially lets you deliver mail via SMTP as if you were using sendmail.


Usage
-----

1. Update the recipient's e-mail address script (line 12)
2. Consider giving the script a name more appropriate considering your specific environment
3. Add the script to your crontab. If you want to run it every five minutes, your entry may look like this:

	
	*/5 * * * * script.sh http://your.url/goes/here 200 /optional/script/path


In this example, a GET request is fired at the specified URL.
If the return code is anything but 200, an e-mail will be sent to the address specified in the script.
The e-mail will contain the unexpected status code, and the output of the optional script specified at the end.
You might want to use that to get the tail of the relevant log file.

Once an issue has been reported, no more reports will be sent until you delete a file that has been created in your home directory with a name that looks something like this:

	.dirty_http:__your.url_goes_here


License
-------

In its brevity and obviousness, this script probably doesn't even count as intellectual property.
In any case, feel free to use it under the terms of the MIT license.
