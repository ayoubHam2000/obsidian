  fastcgi_split_path_info ^(.+.php)(/.+)$

If you don't include the "fastcgi_split_path_info" directive in your NGINX configuration, the entire URL path will be passed to the FastCGI backend as a single parameter. This can cause issues with certain applications that rely on the path information being separated into its individual components.

For example, if you are using PHP-FPM as your FastCGI backend and your URL is "[http://example.com/index.php/path/info](http://example.com/index.php/path/info)", PHP-FPM may not be able to properly parse the path information and could return a 404 error or incorrect results.

By including the "fastcgi_split_path_info" directive with the appropriate regular expression, you can ensure that the script name and path information are properly extracted and passed to the FastCGI backend as separate parameters.

Therefore, it is generally recommended to include the "fastcgi_split_path_info" directive in your NGINX configuration when using a FastCGI backend such as PHP-FPM.